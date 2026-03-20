package exception;

public class DaoNotSavedException extends DaoException {
    public DaoNotSavedException(String entity) {
        super(entity + " could not be saved.");
    }
}