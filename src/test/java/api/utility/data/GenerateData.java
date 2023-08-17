package api.utility.data;

import java.util.Random;

public class GenerateData {

	public static String getEmail() {
		String prefix = "Auto_email";
		String provider = "@tekschool.us";
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider;
		return email;
	}

	// generate random phone number
	public static String getPhoneNumber() {

		String phoneNumber = "";
		for (int i = 0; i < 10; i++) {

			phoneNumber += (int) (Math.random() * 10);
		}
		return phoneNumber;

	}

	public static String phoneNumber() {
		Random rd = new Random();
		int num;
		String m[] = new String[10];
		for (int i = 0; i < m.length; i++) {
			int rdN = rd.nextInt(10) + 1;
			m[i] = Integer.toString(rdN);
		}
		return m[0] + m[1] + m[2] + m[3] + m[4] + m[5] + m[6] + m[7] + m[8] + m[9];

	}

	public static String getLicense() {
		String prefix = "abc";
		int random = (int) (Math.random() * 10000);
		String license = prefix + random;
		return license;
	}

	public static void main(String[] args) {
		System.out.println(phoneNumber());
		System.out.println(getLicense());
	}
}
