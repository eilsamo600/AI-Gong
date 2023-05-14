package gcu.backend.reservationservice.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
// import io.swagger.v3.oas.annotations.parameters.RequestBody;
import org.springframework.web.bind.annotation.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.ws.rs.core.Response;
import gcu.backend.reservationservice.model.Reservation;
import gcu.backend.reservationservice.repository.ReservationRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.http.HttpStatus;

@RestController
@Tag(name = "Reservation", description = "예약 API")
public class ReservationController {

    @Autowired
    private ReservationRepository reservationRepository;

    @PostMapping("/reservation")
    @Operation(summary = "예약 내역 보내기", description = "예약 내역 보내요~.")
    public ResponseEntity<Reservation> postReservation(@Valid @RequestBody Reservation reservation) {
        System.out.print("userInfo = {}" + reservation.toString());
        Reservation savedReservation = reservationRepository.save(reservation);
        return ResponseEntity.ok(savedReservation);

    }

    @GetMapping("/reservations")
    @Operation(summary = "모든 예약 테이블 조회", description = "예약 테이블 정보입니다.")
    public ResponseEntity<List<Reservation>> getReservations() {
        List<Reservation> reservations = reservationRepository.findAll();
        return new ResponseEntity<List<Reservation>>(reservations, HttpStatus.OK);
    }
}
