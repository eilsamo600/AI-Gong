package gcu.backend.classroomservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ClassroomControler {
    @GetMapping("/test")
    public String show() {
        return "Hello Gachon University!";
    }
}
