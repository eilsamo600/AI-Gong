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
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import gcu.backend.reservationservice.model.Incubator;
import gcu.backend.reservationservice.model.Reservation;
import gcu.backend.reservationservice.repository.ReservationRepository;
import gcu.backend.reservationservice.repository.IncubatorRepository;
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

    @GetMapping("/reservation/{email}")
    @Operation(summary = "사용자 예약 테이블 조회", description = "예약 테이블 정보입니다.")
    public ResponseEntity<List<Reservation>> getReservations(@PathVariable String email) {
        List<Reservation> reservations = reservationRepository.findByEmailList(email);
        return new ResponseEntity<List<Reservation>>(reservations, HttpStatus.OK);
    }

    @GetMapping("/reservation/{number}/{date}")
    @Operation(summary = "예약 정보 조회", description = "예약정보입니다")
    public ResponseEntity<List<Reservation>> getAvailableReservation(@PathVariable String number,
            @PathVariable String date) {
        List<Reservation> reservation = reservationRepository.findByNumberAndDate(number, date);
        // if (reservation == null) {
        // return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        // }
        System.out.print("reservationfind" + reservation);
        return new ResponseEntity<List<Reservation>>(reservation, HttpStatus.OK);
    }

    @DeleteMapping("/reservation/{id}")
    @Operation(summary = "특정 예약정보 삭제", description = "특정 예약정보를 삭제합니다.")
    public ResponseEntity<Reservation> deleteReservation(@PathVariable String id) {
        Reservation reservation = reservationRepository.findByEmail(id);

        if (reservation == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        reservationRepository.delete(reservation);

        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/incubators")
    @Operation(summary = "인큐베이터 목록 조회", description = "인큐베이터 정보입니다.")
    public ResponseEntity<List<Incubator>> getIncubators() {
        List<Incubator> incubators = incubatorRepository.findAll();
        return new ResponseEntity<List<Incubator>>(incubators, HttpStatus.OK);
    }

}
