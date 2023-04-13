package gcu.backend.reservationservice.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@Tag(name = "Reservation", description = "예약 API")
public class ReservationController {
    @GetMapping("/test2")
    @Operation(summary = "테스트2", description = "테스트2")
    public ResponseEntity<String> show() {
        return ResponseEntity.ok("my name is incubator!");
    }
}
