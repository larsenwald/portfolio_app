import { application } from "controllers/application"
import DropdownController from "./dropdown_controller"; // Import the dropdown controller

application.register("dropdown", DropdownController); // Register the controller with Stimulus