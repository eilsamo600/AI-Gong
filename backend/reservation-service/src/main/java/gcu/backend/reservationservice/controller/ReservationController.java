package gcu.backend.reservationservice.controller;

import java.util.List;
import java.util.Optional;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.netflix.discovery.converters.Auto;

import io.swagger.v3.oas.annotations.Operation;
// import io.swagger.v3.oas.annotations.parameters.RequestBody;
import org.springframework.web.bind.annotation.RequestBody;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import gcu.backend.reservationservice.jwt.JwtService;
import gcu.backend.reservationservice.model.Incubator;
import gcu.backend.reservationservice.model.Reservation;
import gcu.backend.reservationservice.repository.ReservationRepository;
import gcu.backend.reservationservice.service.ReservationService;
import gcu.backend.reservationservice.repository.IncubatorRepository;
import org.springframework.web.bind.annotation.*;

import org.springframework.http.HttpStatus;

@RestController
@Tag(name = "Reservation", description = "예약 API")
@Slf4j
public class ReservationController {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private IncubatorRepository incubatorRepository;

    @Autowired
    private JwtService jwtService;

    @Autowired
    private ReservationService reservationService;

    @PostMapping("/reservation")
    @Operation(summary = "예약 내역 보내기", description = "예약 내역 보내요~.")
    public ResponseEntity<Reservation> postReservation(@RequestHeader("Authorization") String value,
            @RequestBody Reservation reservation) {
        Optional<String> email = jwtService.extractAccessTokenInString(value)
                .map(token -> jwtService.extractEmail(token)).orElse(Optional.empty());
        if (!email.isPresent()) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        reservation.setEmail(email.get());
        System.out.print(reservation.toString());
        Reservation savedReservation = reservationRepository.save(reservation);
        return ResponseEntity.ok(savedReservation);

    }

    @GetMapping("/reservation")
    @Operation(summary = "사용자 예약 테이블 조회", description = "예약 테이블 정보입니다.")
    public ResponseEntity<List<Reservation>> getReservations(@RequestHeader("Authorization") String value) {
        Optional<String> email = jwtService.extractAccessTokenInString(value)
                .map(token -> jwtService.extractEmail(token)).orElse(Optional.empty());
        if (!email.isPresent()) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        List<Reservation> reservations = reservationRepository.findByEmailList(email.get());
        // Sorting by String date in Reservation class, descending order
        reservations.sort((r1, r2) -> r2.getDate().compareTo(r1.getDate()));

        return new ResponseEntity<List<Reservation>>(reservations, HttpStatus.OK);
    }

    @GetMapping("/reservation/{number}/{date}")
    @Operation(summary = "예약 정보 조회", description = "예약정보입니다")
    public ResponseEntity<List<Reservation>> getAvailableReservation(@PathVariable String number,
            @PathVariable String date) {
        List<Reservation> reservation = reservationRepository.findByNumberAndDate(number, date);
        return new ResponseEntity<List<Reservation>>(reservation, HttpStatus.OK);
    }

    @PostMapping("/reservation/{id}/{state}")
    @Operation(summary = "예약 상태 업데이트", description = "예약 배정완료, 배정하기, 취소완료 상태 업데이트")
    public ResponseEntity<String> updateReservationState(@RequestHeader("Authorization") String value,
            @PathVariable("id") String id,
            @PathVariable("state") int newState) {
        Optional<String> email = jwtService.extractAccessTokenInString(value)
                .map(token -> jwtService.extractEmail(token)).orElse(Optional.empty());
        if (!email.isPresent()) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        // id와 일치하는 데이터를 데이터베이스에서 찾습니다.
        Optional<Reservation> optionalReservation = reservationRepository.findById(new ObjectId(id));

        if (optionalReservation.isPresent()) {
            Reservation reservation = optionalReservation.get();

            if (newState < 0 || newState > 3) {
                return ResponseEntity.badRequest().build();
            }
            // 데이터의 state를 변경합니다.
            if (!reservation.getEmail().equalsIgnoreCase(email.get())) {
                return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
            }
            reservation.setState(newState);
            reservationRepository.save(reservation); // 변경된 데이터를 저장하거나 업데이트하는 로직을 구현해야합니다.

            // 변경된 데이터에 대한 성공 응답을 반환합니다.
            return ResponseEntity.ok("Reservation state updated successfully.");
        } else {
            // id에 해당하는 데이터가 없을 경우 에러 응답을 반환합니다.
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/reservation/{id}")
    @Operation(summary = "특정 예약정보 삭제", description = "특정 예약정보를 삭제합니다.")
    public ResponseEntity<String> deleteReservation(@RequestHeader("Authorization") String value,
            @PathVariable String id) {
        Optional<String> email = jwtService.extractAccessTokenInString(value)
                .map(token -> jwtService.extractEmail(token)).orElse(Optional.empty());
        if (!email.isPresent()) {
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
        try {
            reservationRepository.DeleteByIdAndEmail(new ObjectId(id), email.get());
            return ResponseEntity.ok().build();
        } catch (EmptyResultDataAccessException e) {
            // 예약 ID에 해당하는 예약이 없을 경우 예외 처리
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            // 그 외의 예외 발생 시 예외 처리
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/incubators")
    @Operation(summary = "인큐베이터 목록 조회", description = "인큐베이터 정보입니다.")
    public ResponseEntity<List<Incubator>> getIncubators() {
        List<Incubator> incubators = incubatorRepository.findAll();
        for (Incubator incubator : incubators) {
            incubator.setUsableLevel(reservationService.getUsableLevel(Integer.toString(incubator.get번호())));
        }
        return new ResponseEntity<List<Incubator>>(incubators, HttpStatus.OK);
    }

}
