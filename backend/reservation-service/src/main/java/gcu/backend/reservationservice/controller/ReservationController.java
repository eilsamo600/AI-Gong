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
import gcu.backend.reservationservice.model.Incubator;
import gcu.backend.reservationservice.model.Reservation;
import gcu.backend.reservationservice.repository.ReservationRepository;
import gcu.backend.reservationservice.repository.IncubatorRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import org.springframework.http.HttpStatus;

@RestController
@Tag(name = "Reservation", description = "예약 API")
public class ReservationController {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private IncubatorRepository incubatorRepository;

    @PostMapping("/reservation")
    @Operation(summary = "예약 내역 보내기", description = "예약 내역 보내요~.")
    public ResponseEntity<Reservation> postReservation(@Valid @RequestBody Reservation reservation) {
        System.out.print(reservation.toString());
        Reservation savedReservation = reservationRepository.save(reservation);
        return ResponseEntity.ok(savedReservation);

    }

    @PostMapping("/incubator/post")
    @Operation(summary = "예약 내역 보내기", description = "예약 내역 보내요~.")
    public ResponseEntity<Incubator> postIncubator(@Valid @RequestBody Incubator incubator) {
        System.out.print(incubator.toString());
        Incubator savedReservation = incubatorRepository.save(incubator);
        return ResponseEntity.ok(savedReservation);

    }

    @GetMapping("/reservations")
    @Operation(summary = "모든 예약 테이블 조회", description = "예약 테이블 정보입니다.")
    public ResponseEntity<List<Reservation>> getReservations() {
        List<Reservation> reservations = reservationRepository.findAll();
        return new ResponseEntity<List<Reservation>>(reservations, HttpStatus.OK);
    }

    @GetMapping("/incubator/incubators")
    @Operation(summary = "모든 소회의실 정보 조회", description = "소회의실 정보입니다.")
    public ResponseEntity<List<Incubator>> getIncubators() {
        List<Incubator> incubators = incubatorRepository.findAll();
        return new ResponseEntity<List<Incubator>>(incubators, HttpStatus.OK);
    }

    @DeleteMapping("/reservation/{id}")
    @Operation(summary = "특정 예약정보 삭제", description = "특정 예약정보를 삭제합니다.")
    public ResponseEntity<Reservation> deleteReservation(@PathVariable Long id) {
        reservationRepository.deleteById(id);
        // if (reservation == null) {
        // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        // }
        return new ResponseEntity<Reservation>(HttpStatus.OK);
    }

}
