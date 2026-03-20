package exception;

public class DaoNotDeletedException extends DaoException {
    public DaoNotDeletedException(String entity, Long id) {
        super(entity + " with id " + id + " could not be deleted.");
    }
}
