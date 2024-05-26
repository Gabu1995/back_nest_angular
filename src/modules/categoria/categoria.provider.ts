import { DataSource } from "typeorm"
import { Categoria } from "./entities/categoria.entity"

export const categoriaProviders=[
    {
        provide:'CATEGORIA_REPOSITORY',
        useFactory: (dataSourse:DataSource)=>dataSourse.getRepository(Categoria),
        inject:['DATABASE_CONNECTION_POSTGRES']
    }
]