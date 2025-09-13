package com.example.db_test_java.exception;

public class ScriptAssertionError extends AssertionError {
    public ScriptAssertionError(String message) {
        super(message);
    }

    @Override
    public synchronized Throwable fillInStackTrace() {
        return this;
    }
}
