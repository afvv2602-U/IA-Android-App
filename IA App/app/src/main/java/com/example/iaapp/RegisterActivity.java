package com.example.iaapp;

import static com.example.iaapp.UtilsActivities.openWebPage;

import android.content.Intent;
import android.os.Bundle;
import android.widget.EditText;
import android.widget.ImageButton;
import androidx.appcompat.app.AppCompatActivity;

public class RegisterActivity extends AppCompatActivity {

    private EditText nameEditText;
    private EditText surnameEditText;
    private EditText emailEditText;
    private EditText passwordEditText;
    private ImageButton createAcc;
    private ImageButton twitterButton;
    private ImageButton facebookButton;
    private ImageButton instagramButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.register_page);

        // Initialize all EditText and Button views
        nameEditText = findViewById(R.id.name);
        surnameEditText = findViewById(R.id.surname);
        emailEditText = findViewById(R.id.email);
        passwordEditText = findViewById(R.id.password);
        createAcc = findViewById(R.id.btn_create_acc);

        // Social media buttons
        twitterButton = findViewById(R.id.twitter);
        facebookButton = findViewById(R.id.facebook);
        instagramButton = findViewById(R.id.instagram);

        instagramButton.setOnClickListener(v -> openWebPage("https://www.instagram.com"));

        twitterButton.setOnClickListener(v -> openWebPage("https://www.twitter.com"));

        facebookButton.setOnClickListener(v -> openWebPage("https://www.facebook.com"));

        createAcc.setOnClickListener(v -> submitRegistration());
    }

    private void submitRegistration() {
        // Extract data from EditText fields
        String name = nameEditText.getText().toString();
        String surname = surnameEditText.getText().toString();
        String email = emailEditText.getText().toString();
        String password = passwordEditText.getText().toString();


    }

    private void navigateToMain() {
        // Intent to navigate back to LoginActivity
        Intent intent = new Intent(RegisterActivity.this, LoginActivity.class);
        startActivity(intent);
    }

}
