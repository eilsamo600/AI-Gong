package gcu.backend.classroomservice.model;

import lombok.Data;
import lombok.AllArgsConstructor;

@AllArgsConstructor
@Data
public class ClassRoom {
    String roomid;
    String department;
    int floor;
    int capacity;
    String scale;
    boolean usable;

}
