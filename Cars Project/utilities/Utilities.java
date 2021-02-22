/**
 * @author Tomer Revah 205775083, Ilia Kulmin 320722184
 *
 */
package utilities;
import java.util.ArrayList;
import java.util.Random;
/**
 * @author Sophie Krimberg
 *
 */
public interface Utilities {
	/**
	 * Prints a error message when object is unsuccessfully built
	 * @param wrongVal
	 * @param variable
	 */
	public default void errorMessage(double wrongVal, String variable) {
		
		System.out.print("The value " + wrongVal + " is illegal for" +variable );
	}

	/**
	 * Prints a correcting message when object is rebuilt with correct value
	 * @param wrongVal
	 * @param correct
	 * @param variable
	 */
	public default void correctingMessage(double wrongVal, double correct, String variable) {
		errorMessage(wrongVal, variable);
		System.out.println(", therefore has been replaced with " + correct);
	}

	/**
	 * Prints a success message when object is successfully built
	 * @param objName
	 */
	public default void successMessage(String objName) {
		System.out.println(objName + " has been created.");
	}

	/**
	 * Get random double in given bound
	 * @param minimum
	 * @param maximum
	 * @return
	 */
	public default double getRandomDouble(double minimum, double maximum){
		return  Math.random()*((maximum-minimum)+1)+minimum;
		
	}

	/**
	 *Get random boolean
	 * @return boolean
	 */
	public default boolean getRandomBoolean() {
		return new Random().nextBoolean();
	}

	/**
	 * Get random integer in given bound
	 * @param minimum
	 * @param maximum
	 * @return Integer
	 */
	public default int getRandomInt(int minimum, int maximum) {
		return new Random().nextInt(maximum-minimum)+minimum;
		
	}

	/**
	 * Check if value is in given bound
	 * @param val
	 * @param min
	 * @param max
	 * @return
	 */
	public default boolean checkValue(double val, double min, double max) {
		if (val<min || val>max) 
			return false;
		else
			return true;
	}

	/**
	 * Get array with random integer values
	 * @param minimum
	 * @param maximum
	 * @param maxSize
	 * @return
	 */
	public default ArrayList<Integer> getRandomIntArray(int minimum, int maximum, int maxSize){
		ArrayList<Integer> arr=new ArrayList<Integer>();
		while (arr.size()<maxSize) {
			Integer i=getRandomInt(minimum, maximum);
			if (!arr.contains(i)) {
				arr.add(i);
			}
		}
		return arr;
	}

}
