require 'rails_helper'
require 'byebug'

RSpec.describe "posts", type: :request do 
    
    describe "GET /posts" do
        
        it 'should return OK' do 
            get '/posts'
            #METODO DE INTEGRACION HTTP, RESPONSE TODA LA INFORMACIÓN DE RESPUESTA Y EN EL BODY EL CUERPO DE LA RESPUESTA
            payload = JSON.parse(response.body)
            #METODO EXPECT "PRUEBA"
            expect(payload).to be_empty
            expect(response).to have_http_status(200)
        end
    end

    describe "with data in the DB" do
        #RSpec -> METODO LET SEGUIDO DE UN SIMBOLO Y DESPUES UN BLOQUE, ESTO SIRVE PARA DECLARAR UNA VARIABLE POST 
        #SE LE ASIGNARA LO QUE ESTA DENTRO DE ESE BLOQUE Y ESA VARIABLE ESTARA DISPONIBLE EN CADA PRUEBA
        #CREATE_LIST: implementación de Factory Bot 

        let!(:posts){
            create_list(:post, 10, published: true)
        }

        it "should return all the published posts" do 
            get '/posts'
            payload = JSON.parse(response.body)
                #METODO EXPECT "PRUEBA"
            expect(payload.size).to eq(posts.size)
            expect(response).to have_http_status(200)
        end            
    end

    describe "GET /posts/{id}" do
        
        let!(:post){
           
            create(:post)
        }

        it "should return a post" do 
            

            get "/posts/#{post.id}"
            payload = JSON.parse(response.body)
                #METODO EXPECT "PRUEBA"
            expect(payload).to_not be_empty
            expect(payload["id"]).to eq(post.id)
            expect(response).to have_http_status(200)
        end            
    end



    describe "POST /posts" do 
        
        let!(:user) {

            create(:user)
        }

        it "should create a post" do 

            
                req_payload = {
                    post: {
                        title: 'Titulo',
                        content: 'content',
                        published: false,
                        user_id: user.id
                    }
                }

            

            #POST HTTP
            post "/posts", params: req_payload

            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["id"]).to_not be_nil
            expect(response).to have_http_status(:created)


        end


        it "should return error message on invalid post" do 

            
                req_payload = {
                    post: {
                        content: 'content',
                        published: false,
                        user_id: user.id
                    }
                } 

                #POST HTTP
                post "/posts", params: req_payload

                payload = JSON.parse(response.body)
                expect(payload).to_not be_empty
                expect(payload["error"]).to_not be_empty
                expect(response).to have_http_status(:unprocessable_entity)


        end


    end


    describe "PUT /posts" do 
        
       let!(:article) {create(:post)}

        it "should create a post" do 
            
            
                req_payload = {

                    post: {
                        title: 'Titulo',
                        content: 'content',
                        published: true
                    }
                }

            

            #PuT HTTP
            put "/posts/#{article.id}", params: req_payload

            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["id"]).to eq(article.id)
            expect(response).to have_http_status(:ok)


        end

        it "should return error message on invalid post" do 

            
            req_payload = {
                post: {
                    title: nil,
                    content: nil,
                    published: false
                }
            } 

            #POST HTTP
            put "/posts/#{article.id}", params: req_payload

            payload = JSON.parse(response.body)
            expect(payload).to_not be_empty
            expect(payload["error"]).to_not be_empty
            expect(response).to have_http_status(:unprocessable_entity)


        end

    end

    

       
end

