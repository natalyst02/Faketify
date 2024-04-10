package com.mobile.shared.response;

import com.mobile.shared.constant.Constant;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MobileCommonResponse<T> implements Serializable {

    private static final long serialVersionUID = -6669686067446636607L;

    protected String code;

    protected String message;

    protected T result;

    public MobileCommonResponse(T result) {
        this.code = Constant.SUCCESS_CODE;
        this.message = Constant.SUCCESS_MESSAGE;
        this.result = result;
    }

    public static MobileCommonResponse<Object> internalError() {
        return new MobileCommonResponse<>(
                Constant.INTERNAL_SERVER_ERROR_CODE,
                Constant.INTERNAL_SERVER_ERROR_MESSAGE,
                null
        );
    }
}
