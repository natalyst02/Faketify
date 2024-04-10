package com.mobile.shared.exception;

import org.springframework.http.HttpStatus;

public class AccessDeniedException extends MobileException {

    public AccessDeniedException() {
        super(null, ErrorCodeList.NotFoundLoginInfo.toCode(), ErrorCodeList.NotFoundLoginInfo.toString(), HttpStatus.UNAUTHORIZED);
    }

}
