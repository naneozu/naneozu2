package nnz.nanumservice.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import io.github.eello.nnz.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystem;
import java.util.List;

@Slf4j
@Component
public class FCMInitializer {

    @Value("${fcm.json.path}")
    private FileSystemResource jsonFile;

    @PostConstruct
    public void initialize(){
//        ClassPathResource resource = new ClassPathResource("nnz-firebase.json");
//        FileSystemResource file = new FileSystemResource("/home/fcm/nnz-firebase.json");

        try(InputStream stream = jsonFile.getInputStream()){
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(stream))
                    .build();

            if(FirebaseApp.getApps().isEmpty()){
                FirebaseApp.initializeApp(options);
                log.info("Firebase App Initialization SUCCESS");
            }
        }catch (Exception e){
            throw new RuntimeException(HttpStatus.INTERNAL_SERVER_ERROR.toString());
        }
    }
}
