package com.mobile.shared.exception;

import com.mobile.shared.response.MobileCommonResponse;


/**
 * This exception can be thrown when an invalid or unsupported enum value is encountered in the application.
*/
public class UnsupportedEnumValueException extends RuntimeException {

    private final String value;

    public UnsupportedEnumValueException(String value) {
        this.value = "unsupported value " + value;
    }

    public String getValue() {
        return value;
    }

    public MobileCommonResponse toMobileCommonResponse() {
        return new MobileCommonResponse<>(
                "400",
                this.value,
                null
        );
    }
}
