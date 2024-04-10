package com.mobile.shared.exception;

public enum ErrorCodeList {
    /**
     * Shoud send a notification to the 'Notification Channel' to report an internal error"
     */
    InternalServerError("BASE001", "Lỗi hệ thống", true),
    ExampleException("BASE002", "Exception Example", false),

    InvalidParameter("BASE003", "Invalid Parameter"),

    NotFoundLoginInfo("EX01", "Thông tin đăng nhập không hợp lệ"),

    UserNotFound("EX02", "User not found"),

    NotFoundPlaylist("EX03", "Not found playlist"),

    NotFoundSong("EX04", "Not found song")
    ;

    private final String code;
    private final String message;

    private Boolean shouldAlert = false;

    ErrorCodeList(String code, String message) {
        this.code = code;
        this.message = message;
    }

    ErrorCodeList(String code, String message, Boolean shouldAlert) {
        this.code = code;
        this.message = message;
        this.shouldAlert = shouldAlert;
    }

    public String toCode() {
        return this.code;
    }

    @Override
    public String toString() {
        return this.message;
    }

    public Boolean shouldAlert() {
        return shouldAlert;
    }
}
