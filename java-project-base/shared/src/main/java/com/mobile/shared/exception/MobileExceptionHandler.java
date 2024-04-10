package com.mobile.shared.exception;

import com.mobile.shared.response.MobileCommonResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.security.InvalidParameterException;

@ControllerAdvice
public class MobileExceptionHandler {

    @ExceptionHandler(MobileException.class)
    public ResponseEntity<MobileCommonResponse<String>> handleMobileException(MobileException e) {
        e.printStackTrace();

        /**
         * Consider to send this one to the notification channel when an exception occurs and the 'shouldAlert' attribute is set to true.
         */
        return ResponseEntity.status(e.getHttpStatus()).body(e.toMobileCommonResponse());
    }

    @ExceptionHandler(UnsupportedEnumValueException.class)
    public ResponseEntity<Object> handleUnsupportedEnumValueException(
        UnsupportedEnumValueException e) {
        e.printStackTrace();

        return new ResponseEntity<>(e.toMobileCommonResponse(), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(InvalidParameterException.class)
    public ResponseEntity<Object> handleInvalidParameterException(InvalidParameterException e) {
        e.printStackTrace();

        return new ResponseEntity<>(new MobileCommonResponse<>(
            HttpStatus.BAD_REQUEST.toString(),
            e.getMessage(),
            null
        ), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Object> handleUnwantedException(Exception e) {
        e.printStackTrace();

        /**
         * Consider to send this one to the notification channel when an unwanted exception occurs
         */

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body(MobileCommonResponse.internalError());
    }
}
