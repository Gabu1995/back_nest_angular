import { IsEmail, IsNotEmpty, MaxLength, MinLength } from "class-validator";
import { User } from "../interfaces/user.interface";
export class LoginAuthDto implements User{
   
    @IsNotEmpty()
    @IsEmail()
    mail: string;
    @MinLength(6)
    @MaxLength(25)
    @IsNotEmpty()
    password: string;
}