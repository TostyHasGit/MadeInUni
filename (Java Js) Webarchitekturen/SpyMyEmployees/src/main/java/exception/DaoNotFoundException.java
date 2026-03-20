package exception;

public class DaoNotFoundException extends DaoException {
    public DaoNotFoundException(String entity, Long id) {
        super(entity + " with id " + id + " not found.");
    }
}