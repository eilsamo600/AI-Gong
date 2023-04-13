package gcu.backend.classroomservice.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@Tag(name = "Classroom", description = "강의실 API")
public class ClassroomControler {
    @GetMapping("/test")
    @Operation(summary = "테스트", description = "테스트")
    public String show() {
        return "Hello Gachon University!";
    }
}
