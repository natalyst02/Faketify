package com.mobile.api.controller.client;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.S3Object;
import com.mobile.api.controller.client.request.AddSongToPlaylistRequest;
import com.mobile.api.controller.client.request.AddToFavouriteRequest;
import com.mobile.api.controller.client.request.CreatePlaylistRequest;
import com.mobile.api.controller.client.request.UserLoginRequest;
import com.mobile.api.service.client.UserService;
import com.mobile.api.service.client.dto.CreateUserInput;
import com.mobile.shared.constant.Constant;
import com.mobile.shared.db.entities.Song;
import com.mobile.shared.response.MobileCommonResponse;
import com.mobile.shared.utils.ResponseUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
public class UserController {
    private final UserService userService;
    private final AmazonS3 s3Client;
    @PostMapping("/sign-up")
    public ResponseEntity<MobileCommonResponse<Object>> createUser(
            @RequestBody CreateUserInput input
    ) {
        userService.createUser(input);
        return ResponseUtil.toSuccessCommonResponse(Constant.SUCCESS_MESSAGE);
    }

    @PostMapping("/login")
    public ResponseEntity<MobileCommonResponse<Object>> login(
            @RequestBody UserLoginRequest loginRequest
    ) {
        return ResponseUtil.toSuccessCommonResponse(userService.login(loginRequest));
    }

    @PostMapping("/add-favourite")
    public ResponseEntity<MobileCommonResponse<Object>> addToFavourite(
            @RequestBody AddToFavouriteRequest request
    ) {
        userService.addSongToFavourite(request);
        return ResponseUtil.toSuccessCommonResponse(Constant.SUCCESS_MESSAGE);
    }

    @DeleteMapping("/remove-favourite")
    public ResponseEntity<MobileCommonResponse<Object>> removeFromFavourite(
            @RequestParam("user_id") Long userId,
            @RequestParam("song_id") Long songId
    ) {
        userService.removeSongFromFavourite(userId, songId);
        return ResponseUtil.toSuccessCommonResponse(Constant.SUCCESS_MESSAGE);
    }

    @PostMapping("/{id}/create/playlist")
    public ResponseEntity<MobileCommonResponse<Object>> createPlaylist4User(
            @PathVariable("id") Long userId,
            @RequestBody CreatePlaylistRequest request
    ) {
        return ResponseUtil.toSuccessCommonResponse(userService.createPlaylist4User(userId, request).getId());
    }

    @DeleteMapping("/delete/playlist/{playlistId}")
    public ResponseEntity<MobileCommonResponse<Object>> deletePlaylist(
            @PathVariable("playlistId") Long playlistId
    ) {
        userService.deletePlaylist4User(playlistId);
        return ResponseUtil.toSuccessCommonResponse(Constant.SUCCESS_MESSAGE);
    }


    @GetMapping("/{id}/all/playlist")
    public ResponseEntity<MobileCommonResponse<Object>> getAllPlaylist4User(
            @PathVariable("id") Long userId
    ) {
        return ResponseUtil.toSuccessCommonResponse(userService.getAllPlaylistForUser(userId));
    }

    @PostMapping("/{id}/create/song-playlist")
    public ResponseEntity<MobileCommonResponse<Object>> addSongToPlaylist(
            @PathVariable("id") Long userId,
            @RequestBody AddSongToPlaylistRequest request
    ) {
        return ResponseUtil.toSuccessCommonResponse(userService.addSongPlaylist4User(userId, request));
    }

    @DeleteMapping("/{id}/delete/song-playlist")
    public ResponseEntity<MobileCommonResponse<Object>> deleteSongFromPlaylist(
            @PathVariable("id") Long userId,
            @RequestParam("song_id") Long songId,
            @RequestParam("playlist_id") Long playlistId
    ) {
        userService.deleteSongFromPlaylist(songId, playlistId, userId);
        return ResponseUtil.toSuccessCommonResponse(null);
    }

    @GetMapping("/search-song")
    public ResponseEntity<MobileCommonResponse<Object>> searchSongs(
            @Nullable @RequestParam("key") String key
    ) {
        return ResponseUtil.toSuccessCommonResponse(userService.searchSong(key));
    }

    @GetMapping("/play-song/{songId}")
    public ResponseEntity<Resource> playAndDownloadSong(
            @PathVariable("songId") Long songId
    ) throws IOException {
        // Load the MP3 file from the resources folder
        Song song = userService.getSongInfo(songId);
        String s3Key = song.getS3Key();

        // Get the S3 object
        S3Object s3Object = s3Client.getObject("faketify", "music/"+s3Key);

        // Set up HTTP headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", song.getS3FileName());

        // Wrap the S3 object input stream in an InputStreamResource
        InputStreamResource resource = new InputStreamResource(s3Object.getObjectContent());

        // Return the ResponseEntity with the InputStreamResource and headers
        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }

    @GetMapping("/detail-song/{songId}")
    public ResponseEntity<MobileCommonResponse<Object>> getDetailSong(
            @PathVariable("songId") Long songId
    ) {
        return ResponseUtil.toSuccessCommonResponse(userService.getSongDetail(songId, null));
    }

    @GetMapping("/playlist-song/{playlistId}")
    public ResponseEntity<MobileCommonResponse<Object>> getSongPlaylist(
            @PathVariable("playlistId") Long playlistId
    ) {
        return ResponseUtil.toSuccessCommonResponse(userService.getSongInPlaylist(playlistId));
    }

    @GetMapping("/{userId}/favourite-song")
    public ResponseEntity<MobileCommonResponse<Object>> getUserFavouriteSong(
            @PathVariable("userId") Long userId
    ) {
        return ResponseUtil.toSuccessCommonResponse(userService.getUserFavouriteSong(userId));
    }
}
