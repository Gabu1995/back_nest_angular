import { HttpException, Injectable } from '@nestjs/common';
import { LoginAuthDto } from './dto/login-auth.dto';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from '../users/entities/user.entity';
import { Repository } from 'typeorm';
import { RegisterAuthDto } from './dto/register-auth.dto';
import { hash,compare } from 'bcrypt';

@Injectable()
export class AuthService {

    constructor(private jwtservice:JwtService,
            @InjectRepository(User) private userRepository: Repository<User>){}

    async funRegister(objUser: RegisterAuthDto){
        const {password}=objUser //capturamos solo password de todo el objeto
        //console.log("Antes: ",objUser)
        const plainToHash=await hash(password, 12) //para encriptar contraseña OJO: en impors es bcrypto
        //console.log(plainToHash) //imprimimos el hash pa ver si jala y probamos en el post de auth.rest
        
        objUser={...objUser, password:plainToHash}
        //almacena los datos excepto el password que fue sacado y guardado en password
        console.log("Despues: ", objUser)

        return this.userRepository.save(objUser); //para guardar en la BDD
    }
    async login(credenciales:LoginAuthDto){
        
        const {mail,password}= credenciales
        const user=await this.userRepository.findOne({
            where:{
                mail: mail
            }
        });

        if(!user) return new HttpException('Usuario no encontrado',404);
        
        const verificarPass = await compare(password, user.password)//compare lo importamis manualemente
        
        if(!verificarPass) throw new HttpException('Password invalido',401)

        let payload={mail:user.mail, id:user.id}
        const token= this.jwtservice.sign(payload)
        return {user:user,token:token};
    }
}

