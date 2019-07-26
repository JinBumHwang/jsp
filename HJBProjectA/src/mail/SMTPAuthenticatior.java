package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticatior extends Authenticator {
	 @Override
	    protected PasswordAuthentication getPasswordAuthentication() {
	        return new PasswordAuthentication("jinbumhwang@naver.com","1234qwer");
	    }
}
