package com.mobile.shared.utils;

import com.mobile.shared.response.MobileCommonResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public class ResponseUtil {
    public static ResponseEntity<MobileCommonResponse<Object>> toSuccessCommonResponse(Object data) {
        return new ResponseEntity<>(new MobileCommonResponse<>(data), HttpStatus.OK);
    }
}
