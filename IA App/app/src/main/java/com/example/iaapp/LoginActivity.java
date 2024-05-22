package com.example.iaapp;

import static com.example.iaapp.UtilsActivities.openWebPage;

import android.content.Intent;
import android.os.Bundle;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

public class LoginActivity extends AppCompatActivity {

    private ImageButton twitterButton;
    private ImageButton facebookButton;
    private ImageButton instagramButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_page);

        // Button for signing in
        ImageButton signInButton = findViewById(R.id.sign_in);
        signInButton.setOnClickListener(v -> {
            Intent intent = new Intent(LoginActivity.this, LoginActivity.class);
            startActivity(intent);
        });


        // Additional buttons like "Create Account" or others can be handled here
        TextView createAccount = findViewById(R.id.create_acc);
        createAccount.setOnClickListener(v -> {
            // Handle account creation activity
            Intent intent = new Intent(LoginActivity.this, RegisterActivity.class);
            startActivity(intent);
        });

        twitterButton = findViewById(R.id.twitter);
        facebookButton = findViewById(R.id.facebook);
        instagramButton = findViewById(R.id.instagram);

        instagramButton.setOnClickListener(v -> openWebPage("https://www.instagram.com"));

        twitterButton.setOnClickListener(v -> openWebPage("https://www.twitter.com"));

        facebookButton.setOnClickListener(v -> openWebPage("https://www.facebook.com"));
    }
}
