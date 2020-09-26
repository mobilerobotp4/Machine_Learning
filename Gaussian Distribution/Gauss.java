import java.lang.Math.*;
import java.io.*;
public class Gauss {
    public static void main(String args[]){

        Gauss c = new Gauss();
        c.gu1(5.0, 3.0, 2.0);
}
public static double gu1(double mu,double sigm2,double x)
    {
        double a,b;
        a=1/(Math.sqrt(2*Math.PI))/sigm2;
        b= Math.exp(-0.5*Math.pow((x-mu)/sigm2,2));
        double z= a*b;
        System.out.println(z);
        return(z);
    }
    
    //Output: 0.0806569081730478                                                                                                            
