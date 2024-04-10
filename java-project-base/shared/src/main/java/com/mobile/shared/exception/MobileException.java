package com.mobile.shared.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;
import com.mobile.shared.response.MobileCommonResponse;

@Getter
public class MobileException extends RuntimeException {
    private final String code;

    private final String message;

    private final HttpStatus httpStatus;

    public MobileException(Throwable cause, String code, String message, HttpStatus httpStatus) {
        super(cause);
        this.code = code;
        this.message = message;
        this.httpStatus = httpStatus;
    }

    public MobileException(ErrorCodeList errorCode, HttpStatus httpStatus) {
        this.code = errorCode.toCode();
        this.message = errorCode.toString();
        this.httpStatus = httpStatus;
    }

    public MobileCommonResponse<String> toMobileCommonResponse() {
        return new MobileCommonResponse<>(
                this.code,
                this.message,
                null
        );
    }
    
    public MobileException notFoundLoginInfo() {
        return new MobileException(ErrorCodeList.NotFoundLoginInfo, HttpStatus.UNAUTHORIZED);
    }

    public static MobileException notFoundUser() {
        return new MobileException(ErrorCodeList.UserNotFound, HttpStatus.BAD_REQUEST);
    }

    public static MobileException notFoundPlaylist() {
        return new MobileException(ErrorCodeList.NotFoundPlaylist, HttpStatus.BAD_REQUEST);
    }

    public static MobileException notFoundSong() {
        return new MobileException(ErrorCodeList.NotFoundSong, HttpStatus.BAD_REQUEST);
    }
}
