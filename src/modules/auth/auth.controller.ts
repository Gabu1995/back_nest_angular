import { Body, Controller, Post } from '@nestjs/common';
import { RegisterAuthDto } from './dto/register-auth.dto';
import { AuthService } from './auth.service';
import { LoginAuthDto } from './dto/login-auth.dto';

@Controller('auth')
export class AuthController {
    constructor(private authService:AuthService){

    }
    @Post('Register')
    registerUser(@Body()userObj : RegisterAuthDto){
        console.log(userObj);
        return userObj
    }
    @Post('login')
    
    login(@Body()credenciales: LoginAuthDto){
       return this.authService.login(credenciales)
    }
    
}
