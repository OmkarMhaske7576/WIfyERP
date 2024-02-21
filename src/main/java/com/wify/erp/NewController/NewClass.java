package com.wify.erp.NewController;
import static spark.Spark.*;

public class NewClass {

    public static void main(String[] args) {

        get("/hello", (req, res) -> "Hello World");

    }
}
