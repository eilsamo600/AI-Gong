# 2023 SW Project AI-Gong
## Project Introduction
  The AI building is located far from the main campus, making it difficult for students to find places to spend their free time. 
Therefore, the system is designed to make it easier for students, the primary users, to find empty classrooms at a glance, and to make booking a Metaverse incubator more convenient.  

## Function Introduction
+ Find empty classrooms and view classroom information   


  You can check the usage status of each classroom through the classroom list, and select a classroom to view its timetable, capacity, and other information.
    <p align="center"><img src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/d64e6617defcb1344df8cb119ecf70f78dc970ed/assets/classroom%20information.png" width="23%" height="13%"></img></p>

+ Search for classrooms

  You can search for the classroom you're looking for and it will show you a list of all classrooms that contain the number you entered.
 <p align="center"><img src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/d64e6617defcb1344df8cb119ecf70f78dc970ed/assets/search.png"  width="65%" height="75%"></img></p>


+ Classroom favorites and filters

  Clicking the Bookmark button in the room information will add the room to your favorites list. There are three filters, "Favorites," "Right Now," and "Ending Soon," and only classroom listings that match the selected filter will be fetched and displayed. 
 <p align="center"><img src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/d64e6617defcb1344df8cb119ecf70f78dc970ed/assets/bookmark.png" width="23%" height="13%" ></img>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
  <img
src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/d64e6617defcb1344df8cb119ecf70f78dc970ed/assets/classroom%20information.png" width="23%" height="13%"></img></p>


+ Incubator reservation and reservation history management

  After selecting your preferred room, you can check the date and availability to make a reservation. To view your reservation history, go to your My Info page, where you can manage your reservation history, including canceling reservations and verifying assignments. 
 <p align="center"><img src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/d64e6617defcb1344df8cb119ecf70f78dc970ed/assets/reservation.png" width="23%" height="13%"></img>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <img src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/d64e6617defcb1344df8cb119ecf70f78dc970ed/assets/login%20and%20reservation%20control.png" width="23%" height="13%"></img></p>
  

## Architecture Introduction            
<p align="center"><img src="https://github.com/Jaezic/Sw_Engineering_Project_23/blob/main/assets/structure.png?raw=true" width="80%" height="50%"></img><br/></p>

## Framework
+ Frontend
  - ### Flutter<img style="float: right;" src="https://github.com/Jaezic/Sw_Engineering_Project_23/blob/main/assets/flutter%20logo.png?raw=true" width='200'></img><br/>
    Flutter is an open source, cross-platform GUI application framework released by Google.

+ Backend
  - ### Spring Boot<img style="float: right;" src="https://github.com/Jaezic/Sw_Engineering_Project_23/blob/main/assets/sprig%20boot%20logo.png?raw=true" width='200'></img><br/>   
    An open source tool for data delivery and personal data management using RESTAPI and OAUTH 2.0 services.
  - ### Spring Cloud    
    Spring Cloud helps make implementing MSA structures faster and easier by providing common functionality across distributed systems.
    
    <p align="center"><img src="https://github.com/Jaezic/Sw_Engineering_Project_23/blob/main/assets/spring%20cloud%20architecture.png?raw=true" width="80%" height="50%"></img></p>

## Backend Operating Checking
+ ### Swagger    
  Swagger is a specialized tool that automatically organizes your application's RESTful API documentation. 
  You can connect to "localhost:8000/swagger", select the service, and enter the appropriate parameters for the method of the API you want to test to see what the response actually looks like.
  <p align="center"><img src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/8291c0fe6c9059a0b45e737dd600e324fc589ace/assets/swagger%20api.png" width="80%" height="50%"></img></p> 
  
  *<div align="center"> Above is the list of APIs for the booking service we want to test.</div>* 
  <p align="center"><img src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/69f8161cfa13a271128fb928f0bf7d21761260b1/assets/swagger.png" width="80%" height="50%"></img></p>   
 *<div align="center">This is the result of testing the GET method.</div>*
  


## Frontend Operating Checking
+ ### Flutter build web
  Navigate to the project you want to run, and run the following command on the command line to build.
        
  ``` sh   
  $ fluuter build web   
  ```
  <p align="center">
  <img src="https://github.com/Jaezic/Sw_Engineering_Project_23/blob/main/assets/KakaoTalk_20230615_205642066_01.png?raw=true"width="50%" height="40%"></img></p> 
  
  *<div align="center"> When the build is complete, a static webpage resource is created.</div>*
  
  After the resource is created, type the following on the command line.
  ``` sh
  python -m http.server —bind 127.0.0.1 8080
  ```
  <p align="center">
  <img src="https://raw.githubusercontent.com/Jaezic/Sw_Engineering_Project_23/93058e4cd3afc77b1959863f1daa92d905a42371/assets/ai-gong.png"width="50%" height="40%"></img></p> 
  
  *<div align="center"> You don't need a separate web server, you can use python to use the server. Go to the pre-built build/web directory and execute it like below, and you can see it in your browser at the address 127.0.0.1:8080.</div>*

+ ### Spring boot run
  Navigate to the project you want to run and type the following command in the command window.
  
  ``` sh
  ./mvnw spring-boot:run
  ```

## Sourecode Code Comment
This is the actual classroom model used by the ai-gong project.
``` java
    // Field '_id', type 'ObjectId'
    // Default value is generated by MongoDB
    @Id
    private ObjectId _id; // MongoDB에서 자동으로 생성되는 필드

    // Field '호', type 'String'
    // This value is the classroom number

    // Field '전공', type 'String'
    // This value is the major of the classroom

    // Field '층', type 'int'
    // This value is the floor of the classroom

    // Field '수용인원', type 'int'
    // This value is the capacity of the classroom

    // Field '규모', type 'String'
    // This value is the size of the classroom
    private String 호;
    private String 전공;
    private int 층;
    private int 수용인원;
    private String 규모;
```
Implements a repository for JPA use.
```java
// "ClassRoomRepository", JPA Interface, used to query the database, MongoRepository
public interface ClassRoomRepository extends MongoRepository<ClassRoom, Long> {

    // Query methods, find by 호
    @Query("{ '호' : ?0 }")
    ClassRoom findBy호(String 호);

    // Query methods, find by 호 and email
    List<ClassRoom> findBy호In(List<String> 호);
}
```
The code below is the get method code shown in the swagger test. 
GetMapping to get all the classroom information stored in the DB.
```java
    /*
     * GetMapping("/classrooms") -> ResponseEntity<List<ClassRoom>>
     * This method is used to get all classrooms
     * 
     * Args:
     * - None
     * 
     * Return:
     * - ResponseEntity<List<ClassRoom>>: all classrooms
     */
    @GetMapping("/classrooms")
    @Operation(summary = "모든 강의실 목록 조회", description = "모든 강의실 목록을 조회합니다.")
    public ResponseEntity<List<ClassRoom>> getClassRoomList() {
        List<ClassRoom> classRoomList = classRoomRepository.findAll();
        for (ClassRoom classRoom : classRoomList) { // 강의목록 삭제해서 보냄
            classRoom.set강의목록(null);
        }
        return new ResponseEntity<List<ClassRoom>>(classRoomList, HttpStatus.OK);
    }
```



