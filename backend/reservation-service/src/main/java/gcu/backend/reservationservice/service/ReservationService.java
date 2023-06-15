package gcu.backend.reservationservice.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gcu.backend.reservationservice.model.Reservation;
import gcu.backend.reservationservice.repository.ReservationRepository;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Service
@Data
@Slf4j
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;
    private int START_TIME = 540;
    private int END_TIME = 1020;

    // 사용가능한지 확인
    // level 1 : 사용가능, level 2 : 사용중, level 3 : 예약중, level 4 : 사용 안됨
    public int getUsableLevel(String number) {
        LocalTime now = LocalTime.now();
        LocalDate today = LocalDate.now();
        int hour = now.getHour();
        int minute = now.getMinute();
        int currentTime = hour * 60 + minute;
        if (currentTime >= END_TIME) {
            log.info("currentTime >= END_TIME");
            return 4;
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYYMMdd");
        String DAY = today.format(formatter);
        log.info(number);
        log.info(DAY);
        List<Reservation> reservation = reservationRepository.findByNumberAndDate(number, DAY);
        if (reservation.isEmpty()) {
            log.info("reservation is empty");
            return 1;
        }

        for (Reservation r : reservation) {
            if (r.getState() == 2) {
                continue;
            }
            List<Integer> times = r.getTime();
            Integer start = times.get(0) * 30 + START_TIME;
            Integer end = (times.get(times.size() - 1) + 1) * 30 + END_TIME;
            log.info(start.toString(), end.toString(), currentTime);
            if (start < currentTime && currentTime < end) {
                if (r.getState() == 0) {
                    return 3;
                }
                return 2;
            }

        }
        return 1;

    }
}
