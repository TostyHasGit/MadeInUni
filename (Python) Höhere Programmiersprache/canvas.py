#!/usr/bin/python3
"""Paint many circles on a canvas concurrently.
Expects a module 'particle' with a class 'Particle'.
You do not need to read this module, just implement
the particle module.
"""

import time
import tkinter as tk
from threading import Event, Lock

from PIL import ImageTk


RADIUS = 2
WIDTH, HEIGHT = 400, 400
FPS = 25
COLOR_GREEN = "#00FF00"
COLOR_GRAY = "#DDDDDD"
COLOR_YELLOW = "#FAFAC8"


class Animate:
    "executes a (redraw) task repeatedly "

    def __init__(self, root, update=None, wait_time=100):
        "initialize animate loop, needs tk root, wait_time in msecs"
        self.root = root
        self.wait_time = wait_time
        self.update = update
        self.done = Event()
        self.first = True
        self.animate()

    def animate(self):
        "a loop updating at fixed rate (the ui)"
        if not self.done.is_set():
            start = time.time()
            if self.first:  # skip the first beat
                self.first = False
            else:
                self.update()
            took = int((time.time()-start)*1000)  # in ms
            remaining = self.wait_time-took
            # print(self.wait_time, took, remaining)
            if remaining < 0:
                print("update took too long...")
                remaining = 0
            self.root.after(remaining, self.animate)

    def cancel(self):
        "stop animation loop, stop updating"
        self.done.set()


class ObjectCanvas(tk.Canvas):
    "draws a collection of objects supporting get_position"

    MAX_OBJECTS = 333

    def __init__(self, master=None):
        tk.Canvas.__init__(self, master, background=COLOR_YELLOW,
                           width=WIDTH, height=HEIGHT)
        self.lock = Lock()  # for self.objects
        self.objects = []
        self.paused = True
        self.radius = RADIUS
        self.animate = Animate(self._root(),
                               self.update_circles,
                               int((1.0/FPS)*1000))

    def create_add_object(self, obj_class):
        """create and adds an object to be drawn if space,
        must support get_position return tuple (x,y) in [0..1], [0..1]
        """
        if self.no_objects() >= self.MAX_OBJECTS:
            msg = f"not more than {self.MAX_OBJECTS} objects"
            self._root().after_idle(lambda: print(msg))
            return False
        obj = obj_class() # create it
        radius = self.radius
        x_center, y_center = obj.get_position()
        xlu, ylu = x_center-radius, y_center-radius
        xrl, yrl = x_center+radius, y_center+radius
        obj_id = self.create_oval(xlu, ylu, xrl, yrl, fill='gray70')
        with self.lock:
            if not self.paused:  # assume obj is paused is default
                obj.cont()
            self.objects.append((obj_id, obj))
        return True

    def pause(self):
        "pause all threads"
        with self.lock:
            self.paused = True
            for _, obj in self.objects:
                obj.pause()

    def cont(self):
        "unpause/continue all threads"
        with self.lock:
            self.paused = False
            for _, obj in self.objects:
                obj.cont()

    def no_objects(self):
        "number of all objects"
        with self.lock:
            return len(self.objects)

    def update_circles(self):
        "updates the displayed circles"
        radius = self.radius
        # start = time.time()
        updates = []
        with self.lock:
            for obj_id, obj in self.objects:
                x_center, y_center = obj.get_position()
                x_center *= WIDTH
                y_center *= HEIGHT
                xlu, ylu = x_center-radius, y_center-radius
                xrl, yrl = x_center+radius, y_center+radius
                updates.append((obj_id, xlu, ylu, xrl, yrl))
        # took = time.time()-start
        # typically less than a millisecond for a couple of hundred
        # print("getting coordinates per frame took %5.2f ms" % (took*1000))

        def doupdates():  # do the updates outside of the lock
            for tup in updates:
                self.coords(*tup)
        # self._root().after_idle(doupdates) # as soon as it is safe
        # start = time.time()
        doupdates()  # it is okay to do in the animation loop directly
        # took = time.time()-start
        # typically the limiting factor for the animation, xx ms
        # canvas is expensive
        # print("setting coordinates per frame took %5.2f ms" % (took*1000))

    def cancel(self):
        "cancel update and deletes all items"
        self.animate.cancel()
        with self.lock:
            objects_tojoin = self.objects[:]
            self.objects.clear()  # no more redraw
        for _, obj in objects_tojoin:
            obj.stop()  # stop the threads

    def join(self):
        "join, must have been canceled before"
        # may not necessearily be joinable...
        # for _, obj in self.objects_tojoin: # the remembered objects
        #    obj.join(1.0) # timeout
        # self.delete(tk.ALL) # do not clear canvas, may be a race


IMG_DOT = b"#define empty_width 10\n#define empty_height 10\nstatic char empty_bits[] = {\n  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \n  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, };\n"
def _get_dot(color=COLOR_GRAY):
    "create an image of a small square rectangle"
    return ImageTk.BitmapImage(background=color, data=IMG_DOT)


class OnOffButton(tk.Checkbutton):
    "An on/off button with indicator and state variable"

    def __init__(self, master, text, command, indicator=False,
                 color_on=COLOR_GREEN, color_off=COLOR_GRAY):
        self.on_dot = _get_dot(color=color_on)
        self.off_dot = _get_dot(color=color_off)
        tk.Checkbutton.__init__(self, master,
                                compound=tk.LEFT,
                                anchor=tk.N+tk.W,
                                padx=5,
                                pady=5,
                                text=" " + text,
                                indicator=indicator)
        self.state = tk.IntVar()
        if not self["indicator"]:
            self["image"] = self.off_dot
        self.command = command
        self["command"] = self.switch

    def turn_on(self):
        "turn button on"
        self.state.set(True)
        if not self["indicator"]:
            self["image"] = self.on_dot
        self.update_command()

    def turn_off(self):
        "turn button off"
        self.state.set(False)
        if not self["indicator"]:
            self["image"] = self.off_dot
        self.update_command()

    def get(self):
        "get the current state, on/off"
        return self.state.get()

    def switch(self):
        "on->off or off->on"
        if self.state.get():
            self.turn_off()
        else:
            self.turn_on()

    def update_command(self):
        "called on change of the button state"
        self.command(self.state.get())


class CanvasApp(tk.Frame):
    """Allows to animate a collections of objects with own update_thread
    management. Must support pause to pause the updates and cont to continue
    the updates as well as stop to finally stop the updates.
    """

    def __init__(self, master=None, object_class=None):
        tk.Frame.__init__(self, master)
        self.object_class = object_class
        self.pack()
        self.create_widgets()
        self._root().protocol("WM_DELETE_WINDOW", self.endit)

    def create_widgets(self):
        "create all widgets"
        left = tk.Frame(self)
        left.grid(row=0, column=0, sticky=tk.N+tk.S)
        right = tk.Frame(self)
        right.grid(row=0, column=1, sticky=tk.N+tk.S)
        quit_button = tk.Button(left, text="Quit")
        quit_button["command"] = self.endit
        quit_button.grid(row=0, sticky=tk.E+tk.W)
        add_button = tk.Button(left, text="Add")
        add_button["command"] = self.add
        add_button.grid(row=1, sticky=tk.E+tk.W)
        add_button5 = tk.Button(left, text="Add 5")
        add_button5["command"] = lambda: self.add(no_obj=5)
        add_button5.grid(row=2, sticky=tk.E+tk.W)
        add_button20 = tk.Button(left, text="Add 20")
        add_button20["command"] = lambda: self.add(no_obj=20)
        add_button20.grid(row=3, sticky=tk.E+tk.W)
        self.animate_button = OnOffButton(left, text="Animate",
                                          command=self.animate)
        self.animate_button.grid(row=4, sticky=tk.E+tk.W)
        left.rowconfigure(4, weight=1)
        self.label = tk.Label(left, text="Objekte: 0")
        self.label.grid(row=6, sticky=tk.E+tk.W)
        self.canvas = ObjectCanvas(right)
        self.canvas.pack()

    def add(self, no_obj=1):
        "add a fixed number of objects"
        for _ in range(no_obj):
            if not self.canvas.create_add_object(self.object_class):
                break
        self.label["text"] = f"Objekte: {self.canvas.no_objects()}"

    def animate(self, checked):
        "animate the objects"
        if checked:
            self.canvas.cont()
        else:
            self.canvas.pause()

    def endit(self):
        "end updating, quit program"
        self.canvas.cancel()
        time.sleep(0.3)
        self.canvas.join()
        self._root().destroy()


def main():
    "main"
    root = tk.Tk()
    import particle  # your code!
    app = CanvasApp(root, particle.Particle)
    app.mainloop()


if __name__ == '__main__':
    main()
