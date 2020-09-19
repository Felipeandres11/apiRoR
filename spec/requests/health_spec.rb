require 'rails_helper'

RSpec.describe "Health endpoint", type: :request do 
    
    describe 'GET /health' do
        before { get '/health'}
        
        it 'should return OK' do 
            #METODO DE INTEGRACION HTTP, RESPONSE TODA LA INFORMACIÓN DE RESPUESTA Y EN EL BODY EL CUERPO DE LA RESPUESTA
            payload = JSON.parse(response.body)
            #METODO EXPECT "PRUEBA"
            expect(payload).not_to be_empty
            expect(payload['api']).to eq('OK')
        end

        it 'should return status code 200' do 
            #METODO DE INTEGRACION HTTP, RESPONSE TODA LA INFORMACIÓN DE RESPUESTA Y EN EL BODY EL CUERPO DE LA RESPUESTA
           
            #METODO EXPECT "PRUEBA"
            expect(response).to have_http_status(200)
           
        end
    end

end