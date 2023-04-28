package gcu.backend.classroomservice.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@Data
@Document(collection = "classroom")
public class ClassRoom {

    @Id
    private Long id;

    private String 호;
    private String 전공;
    private int 층;
    private int 수용인원;
    private String 규모;
    private List 강의목록;
    private boolean usable;

}
