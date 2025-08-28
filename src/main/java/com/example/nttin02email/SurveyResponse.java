package com.example.nttin02email;

import java.io.Serializable;
import java.time.LocalDate;

public class SurveyResponse implements Serializable {
    private String firstName;
    private String lastName;
    private String email;
    private LocalDate dob;       // ngày sinh
    private String hearAbout;    // search | word | social | other
    private boolean likeOffers;  // checkbox 1
    private boolean emailUpdates;// checkbox 2
    private String contactBy;    // both | email | postal

    // --- Getters/Setters ---
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }

    public String getHearAbout() { return hearAbout; }
    public void setHearAbout(String hearAbout) { this.hearAbout = hearAbout; }

    public boolean isLikeOffers() { return likeOffers; }
    public void setLikeOffers(boolean likeOffers) { this.likeOffers = likeOffers; }

    public boolean isEmailUpdates() { return emailUpdates; }
    public void setEmailUpdates(boolean emailUpdates) { this.emailUpdates = emailUpdates; }

    public String getContactBy() { return contactBy; }
    public void setContactBy(String contactBy) { this.contactBy = contactBy; }
}
