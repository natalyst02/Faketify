package com.mobile.api.controller.admin;

import com.mobile.api.service.admin.AdminService;
import com.mobile.api.controller.admin.request.AddArtistRequest;
import com.mobile.api.controller.admin.request.AddSongRequest;
import com.mobile.shared.response.MobileCommonResponse;
import com.mobile.shared.utils.ResponseUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/admin")
public class AdminController {

    private final AdminService adminService;

    @PostMapping("/song/add")
    public ResponseEntity<MobileCommonResponse<Object>> addSong(
            @RequestBody AddSongRequest request
    ) {
        return ResponseUtil.toSuccessCommonResponse(null);
    }


    @PostMapping("/artist/add")
    public ResponseEntity<MobileCommonResponse<Object>> addArtist(
            @RequestBody AddArtistRequest request
    ) {
        adminService.addArtist(request);
        return ResponseUtil.toSuccessCommonResponse(null);
    }
}
