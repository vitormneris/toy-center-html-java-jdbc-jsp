CREATE DATABASE IF NOT EXISTS toycenter_db;
USE toycenter_db;

CREATE TABLE IF NOT EXISTS toy_table (
    toy_code INT AUTO_INCREMENT KEY NOT NULL,
    toy_image VARCHAR(255) NOT NULL,
    toy_name VARCHAR(255) NOT NULL,
    toy_brand VARCHAR(255) NOT NULL,
    toy_price DECIMAL(12, 2) NOT NULL,
    toy_description VARCHAR(255) NOT NULL,
    toy_details TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS category_table (
    category_code INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    category_image VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS toy_category (
    toy_code_fk INT NOT NULL,
    category_code_fk INT NOT NULL,
    PRIMARY KEY (toy_code_fk, category_code_fk),
    FOREIGN KEY (toy_code_fk) REFERENCES toy_table(toy_code),
    FOREIGN KEY (category_code_fk) REFERENCES category_table(category_code)
);

CREATE TABLE IF NOT EXISTS user_table (
    user_code INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    user_password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS toy_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    toy_code INT,
    toy_image VARCHAR(255),
    toy_name VARCHAR(255),
    toy_brand VARCHAR(255),
    toy_price DECIMAL(12, 2),
    toy_description VARCHAR(255),
    toy_details TEXT,
    operation VARCHAR(10) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS category_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_code INT,
    category_name VARCHAR(255),
    operation VARCHAR(10) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS toy_category_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    toy_code_fk INT,
    category_code_fk INT,
    operation VARCHAR(10) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_code INT,
    user_name VARCHAR(255),
    user_email VARCHAR(255),
    user_password VARCHAR(255),
    operation VARCHAR(10) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER insert_toy_log AFTER INSERT ON toy_table
FOR EACH ROW
BEGIN
    INSERT INTO toy_log (toy_code, toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details, operation) 
    VALUES (NEW.toy_code, NEW.toy_image, NEW.toy_name, NEW.toy_brand, NEW.toy_price, NEW.toy_description, NEW.toy_details, 'INSERT');
END$$

CREATE TRIGGER insert_category_log AFTER INSERT ON category_table
FOR EACH ROW
BEGIN
    INSERT INTO category_log (category_code, category_name, operation) 
    VALUES (NEW.category_code, NEW.category_name, 'INSERT');
END$$

CREATE TRIGGER insert_toy_category_log AFTER INSERT ON toy_category
FOR EACH ROW
BEGIN
    INSERT INTO toy_category_log (toy_code_fk, category_code_fk, operation) 
    VALUES (NEW.toy_code_fk, NEW.category_code_fk, 'INSERT');
END$$

CREATE TRIGGER insert_user_log AFTER INSERT ON user_table
FOR EACH ROW
BEGIN
    INSERT INTO user_log (user_code, user_name, user_email, user_password, operation) 
    VALUES (NEW.user_code, NEW.user_name, NEW.user_email, NEW.user_password, 'INSERT');
END$$

CREATE TRIGGER update_toy_log AFTER UPDATE ON toy_table
FOR EACH ROW
BEGIN
    INSERT INTO toy_log (toy_code, toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details, operation) 
    VALUES (NEW.toy_code, NEW.toy_image, NEW.toy_name, NEW.toy_brand, NEW.toy_price, NEW.toy_description, NEW.toy_details, 'UPDATE');
END$$

CREATE TRIGGER update_category_log AFTER UPDATE ON category_table
FOR EACH ROW
BEGIN
    INSERT INTO category_log (category_code, category_name, operation) 
    VALUES (NEW.category_code, NEW.category_name, 'UPDATE');
END$$

CREATE TRIGGER update_toy_category_log AFTER UPDATE ON toy_category
FOR EACH ROW
BEGIN
    INSERT INTO toy_category_log (toy_code_fk, category_code_fk, operation) 
    VALUES (NEW.toy_code_fk, NEW.category_code_fk, 'UPDATE');
END$$

CREATE TRIGGER update_user_log AFTER UPDATE ON user_table
FOR EACH ROW
BEGIN
    INSERT INTO user_log (user_code, user_name, user_email, user_password, operation) 
    VALUES (NEW.user_code, NEW.user_name, NEW.user_email, NEW.user_password, 'UPDATE');
END$$

CREATE TRIGGER delete_toy_log AFTER DELETE ON toy_table
FOR EACH ROW
BEGIN
    INSERT INTO toy_log (toy_code, toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details, operation) 
    VALUES (OLD.toy_code, OLD.toy_image, OLD.toy_name, OLD.toy_brand, OLD.toy_price, OLD.toy_description, OLD.toy_details, 'DELETE');
END$$

CREATE TRIGGER delete_category_log AFTER DELETE ON category_table
FOR EACH ROW
BEGIN
    INSERT INTO category_log (category_code, category_name, operation) 
    VALUES (OLD.category_code, OLD.category_name, 'DELETE');
END$$

CREATE TRIGGER delete_toy_category_log AFTER DELETE ON toy_category
FOR EACH ROW
BEGIN
    INSERT INTO toy_category_log (toy_code_fk, category_code_fk, operation) 
    VALUES (OLD.toy_code_fk, OLD.category_code_fk, 'DELETE');
END$$

CREATE TRIGGER delete_user_log AFTER DELETE ON user_table
FOR EACH ROW
BEGIN
    INSERT INTO user_log (user_code, user_name, user_email, user_password, operation) 
    VALUES (OLD.user_code, OLD.user_name, OLD.user_email, OLD.user_password, 'DELETE');
END$$

DELIMITER ;

INSERT INTO category_table (category_name, category_image) VALUES ('Bonecos', 'image/dataBaseImageCategory/boneco.jpg');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) 
VALUES 
    ('image/dataBaseImageToy/pikachu.webp', 'Pikachu', 'Pokémon Company', 129.99, 'Boneco do famoso Pokémon Pikachu.', 'Ideal para decorar a pratilheira do seu quarto, 18cm.'),
    ('image/dataBaseImageToy/buzz.jpg', 'Buzz Lightyear', 'Disney', 359.99, 'Boneco articulado do famoso personagem de Toy Story.', 'Com luzes, sons e asas retráteis, 20cm.'),
    ('image/dataBaseImageToy/elza.jpg', 'Elsa', 'Hasbro', 89.99, 'Boneca da princesa Elsa do filme Frozen.', 'Vestido brilhante e cabelo trançado, 20cm.'),
    ('image/dataBaseImageToy/mickey.webp', 'Mickey Mouse', 'Disney', 59.99, 'O boneco do tão famoso Mickey Mouse', 'Desing clássico de suas primeiras versões nos desenhos, 15cm.'),
    ('image/dataBaseImageToy/hulk.webp', 'Hulk', 'Hashbro', 149.99, 'Boneco articulado do gigante verde Hulk.', 'Braços e pernas articulados juntamente com um belo desing, 30cm.'),
    ('image/dataBaseImageToy/woody.jpg', 'Woody', 'Pixar', 434.99, 'Boneco do xerife Woody do famoso filme Toy Story.', 'Com chapéu, lenço e cinto, 20cm.');

INSERT INTO category_table (category_name, category_image) VALUES ('Pelúcia', 'image/dataBaseImageCategory/pelucia.png');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) 
VALUES 
    ('image/dataBaseImageToy/urso.webp', 'Urso de Pelúcia Marrom', 'Hongyao.', 39.99, 'Urso de pelúcia macio e fofo para abraços aconchegantes.', 'Alta qualidade e desing, Tamanho: 40cm, Material: Pelúcia de alta qualidade.'),
    ('image/dataBaseImageToy/coelho.webp', 'Coelho de Pelúcia Rosa', 'GUND', 259.99, 'Coelho de pelúcia adorável com laço na orelha.', 'Ótimo desing e cor chamativa, Tamanho: 30cm, Material: Pelúcia felpuda.'),
    ('image/dataBaseImageToy/gato.webp', 'Gatinho de Pelúcia Cinza', 'Disney', 120.99, 'Gatinho de pelúcia macio com olhos brilhantes e nariz bordado.', 'Pelucia com um ótimo material, Altura: 25cm, Material: Pelúcia e algodão.'),
    ('image/dataBaseImageToy/panda.webp', 'Panda de Pelúcia Gigante', 'Ty', 49.99, 'Panda de pelúcia grande e fofinho para abraços apertados.', 'Altura: 70cm, Material: Pelúcia de luxo.'),
    ('image/dataBaseImageToy/elefante.jpg', 'Elefante de Pelúcia Roxo', 'Build-A-Bear', 99.99, 'Elefante de pelúcia com tromba levantada e orelhas grandes.', 'Grande elefante fofo, Tamanho: 50cm, Material: Pelúcia macia.'),
    ('image/dataBaseImageToy/cachorro.webp', 'Cachorro de Pelúcia Dálmata', 'Fofy Toys', 65.99, 'Cachorro de pelúcia com manchas características da raça dálmata.', 'Material excelente e desing chamativo, Tamanho: 35cm, Material: Pelúcia e enchimento de poliéster.'),
    ('image/dataBaseImageToy/girafa.webp', 'Girafa de Pelúcia Marrom', 'Aurora World', 39.99, 'Girafa de pelúcia com pescoço longo e manchas marrons.', 'Pelucia com belo desing, parece até de verdade! Altura: 30cm, Material: Pelúcia felpuda.'),
    ('image/dataBaseImageToy/coruja.webp', 'Coruja de Pelúcia Fofinha', 'Toyng', 99.99, 'Coruja de pelúcia com olhos grandes e asas macias.', 'Cores chamativas e desing criattivo, Tamanho: 30cm, Material: Pelúcia e algodão.');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) 
VALUES
    ('image/dataBaseImageToy/JogoDetetive.webp', 'Jogo Detetive', 'Estrela', 100.99, 'Jogo Detetive com App - Estrela', 'Jogo Detetive com App - Estrela! Um jogo de investigação acima de qualquer suspeita! Tudo começou na mansão de um rico industrial, Dr. Pessoa, a vítima do crime. Como um verdadeiro Sherlock, você está lá. Só que além de detetive, você também é um suspeito! Para chegar cada vez mais perto da solução deste mistério, vá entrando com seu peão nos possíveis locais do crime e dando palpites sobre o culpado e arma usada. Tire sua deduções e descubra a cada partida, um novo e emocionante mistério!'),
    ('image/dataBaseImageToy/JogoBancoImobiliario.webp', 'Banco Imobiliário', 'Estrela', 120.99, 'Jogo de Tabuleiro - Banco Imobiliário - Estrela', 'O sucesso do Banco Imobiliário agora com realidade aumentada! O jogador poderá interagir e ver seus imóveis se formando no tabuleiro para uma experiência ainda mais completa, com mais diversão nesse clássico jogo clássico da Estrela.'),
    ('image/dataBaseImageToy/JogoFrozenTiraVaretas.webp', 'Frozen 2 - Tira Varetas', 'Elka', 75.99, 'Jogo - Disney - Frozen 2 - Tira Varetas - Elka', 'Você está preparado para momentos de grandes emoções? O Jogo - Disney - Frozen 2 - Tira Varetas - Elka é uma brincadeira muito simples, mas muito divertida! É pura emoção! Encaixe as varetas e depois coloque as bolinhas na torre. Gire a roleta para descobrir quantas varetas você deve tirar. Depois remova uma a uma. Quem deixar cair menos bolinhas, é o vencedor!'),
    ('image/dataBaseImageToy/JogoCartasPokemon.webp', 'Jogo de Cartas Pokemon', 'Copag', 30.99, 'Jogo de Cartas - Pokémon - Ev04 - Blister Triplo - Copag', 'Descubra as anomalias da Área Zero! Mergulhe nas nuvens e explore uma terra que parece estar desvinculada ao tempo! Com ataques ferozes, Pokémon Ancestrais, como Lua Estrondo ex e Choque Areia ex, aparecem ao lado de Pokémon Futuristas sintéticos, como Valentia Férrea ex e Mãos Férreas ex. Enquanto isso, Garchomp ex, Mewtwo ex e outros podem Terastalizar para ganhar novos tipos, ao mesmo tempo que Armarouge ex, Gholdengo ex e mais Pokémon ex juntam-se à batalha. Muitas aventuras estão à sua espera quando as linhas do tempo colidem na expansão Escarlate e Violeta — Fenda Paradoxal do Pokémon Estampas Ilustradas.'),
    ('image/dataBaseImageToy/JogoCaraACara.webp', 'Cara a Cara', 'Estrela', 93.99, 'Jogo Cara a Cara 2018 - Estrela', 'O clássico jogo infantil de perguntas para desvendar o personagem misterioso está ainda mais divertido! Cada jogador seleciona um dos personagens e outro faz perguntas sobre as características. O vencedor é quem adivinhar qual é a cara do seu oponente primeiro. O game é indicado para dois participantes!'),
    ('image/dataBaseImageToy/JogoCartasUno.webp', 'Jogo de Cartas UNO', 'Copag', 19.99, 'Jogo de Cartas - UNO - Copag', 'O Jogo de Cartas UNO da Copag é diversão para toda a família. É preciso ser esperto para vencer e atrapalhar os adversários. Livre-se depressa de todas as suas cartas combinando cores e números. Use as cartas de ação para atrapalhar os oponentes. Vence quem conseguir ficar sem cartas primeiro. Mas quando restar uma única carta na mão, não se esqueça de gritar o nome do jogo: UNO!'),
    ('image/dataBaseImageToy/JogoPlantaPiranha.webp', 'Planta Piranha - Super Mario', 'Epoch', 154.99, 'Jogo de Tabuleiro - Planta Piranha - Super Mario - Fuga - 2 a 4 Jogadores', 'Super Mario Piranha Plant Escape! é um jogo de tabuleiro emocionante. Siga as instruções nos dados e mova sua figura no tabuleiro. Quem for atacado pela Planta Piranha perde. Duas figuras de personagens do Super Mario e duas placas de personagens estão incluídas. Adequado para idades a partir de quatro anos 2 - 4 pessoas podem jogar ao mesmo tempo. Você pode jogar o Piranha Plant Escape com qualquer uma das figuras dos jogos da LINK SYSTEM (vendidos separadamente)'),
    ('image/dataBaseImageToy/JogoGenius.webp', 'Jogo Genius', 'Estrela', 61.99, 'Mini Jogo Genius Para Viagem', 'O clássico jogo dos anos 80 agora com uma versão de bolso! Aceite o desafio e leve para onde quiser. O objetivo do jogo é pensar rápido e conseguir repetir as sequências de som e luz. São 4 níveis de dificuldade, 3 jogos diferentes e 5 maneiras de jogar! É diversão garantida. Especificações: Idade: A partir de 6 anos Contém na Embalagem: 1 mini Genius Composição: Plástico Selo de Segurança do Inmetro: CE-BRI/INNAC00471-32A NM 300/2002 Alimentação: 3 baterias LR44 Funcionalidades e Benefícios: Memória, lógica e raciocínio Interatividade do Produto: Eletrônico Objetivo do Jogo: Conseguir a maior pontuação, acertando as sequências dadas pelo Genius Jogadores: Para 1 jogador ou +'),
    ('image/dataBaseImageToy/JogoWar.webp', 'Jogo War', 'Grow', 177.99, 'Jogo War - Edição Especial', 'Jogo War - Edição Especial da Grow! Com War, uma batalha nunca é igual a outra, e cada jogador precisa usar toda sua inteligência, astúcia e muita estratégia para derrotar seus adversários e conquistar territórios e continentes. War Edição Especial traz todo o requinte que o jogo War merece, com miniaturas de soldados e tanques representando os exércitos, tabuleiro maior e embalagem diferenciada. Confira o melhor jogo de estratégia de todos os tempos em uma versão de luxo.'),
    ('image/dataBaseImageToy/JogoBloqueio.webp', 'Jogo de Tabuleiro - Bloqueio', 'Grow', 61.99, 'Jogo de Tabuleiro - Bloqueio - Preto - Grow', 'O jogo onde o caminho para a vitória é uma desafiadora mistura entre avanços e barreiras. O jogador deverá escolher entre avançar ou colocar uma barreira para impedir seus adversários. Eles devem criar estratégias únicas, antecipando jogadas e surpreendendo seus oponentes. Cada partida é uma batalha de inteligência! Vence aquele que atravessar o tabuleiro primeiro!');

INSERT INTO category_table (category_name, category_image) VALUES ( 'Jogos de Mesa','image/dataBaseImageCategory/jogosTabuleiro.jpg');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) 
VALUES 
    ('image/dataBaseImageToy/InstumentoMixer.webp', 'Brinquedo DJ Mixer', 'Multikids', 249.90, 'Brinquedo Eletrônico - DJ Mixer - Multikids - Preto', 'Aperte o play e divirta-se com diferentes ritmos e estilos musicais! - Saída de áudio alto-falante externo. - Mixer controlador. - Controle dos ritmos dance beats e Hip-Hop. - Entrada de áudio media player / smartphone. - Controle de batidas por minuto. - Botões de efeito. - Efeitos sonoros e melodias. - Ritmos dance beats e Hip-Hop. - Controle de volume. - Painel de Led 9 teclas separadas. Ideal para 4+ Anos Alimentação: 3 pilhas AA (Inclusas).'),
    ('image/dataBaseImageToy/InstrumentoBarbieMicrofone.webp', 'Microfone - Barbie', 'Fun', 81.99, 'Microfone - Barbie - Rockstar - Fun', 'Sempre incrível! O novo microfone da Barbie com MP3 possibilita realizar uma grande performance onde quer que você esteja. Conecte seu celular ou MP3, com o cabo, para tocar suas músicas preferidas e cante junto sem perder o tom. Sua voz e a música soaram pela pequena saída de som que fica na base do microfone. O show fica ainda mais completo com as coloridas luzes de LED que brilham em seu bocal. Funciona com 3 pilhas AAA (não inclusas). Recomendação: 3+'),
    ('image/dataBaseImageToy/InstrumentoPianoCachorrinho.webp', 'Piano do Cachorrinho', 'Fisher-Price', 149.99, 'Piano do Cachorrinho - Laugh & Learn - Fisher-Price', 'Com quatro formas de jogar, o Piano do Cachorrinho - Laugh & Learn - Fisher-Price mantém o seu mini-músico ocupado a “compor” e a aprender durante todo o tempo de jogo. Como seu bebê pressiona as teclas do piano iluminado, eles são recompensados com notas de piano real, ou com deliciosos sons de pato, sons de vaca tonta, ou canções lúdicas e frases sobre números, cores e formas! E com um identificador de fácil alcance, você pode levar a diversão musical boba onde quer que você e seu bebê forem'),
    ('image/dataBaseImageToy/InstrumentoBarbieBateria.webp', 'Bateria Infantil - Barbie', 'Fun', 141.99, 'Bateria Infantil - Barbie - Dreamtopia - Fun', 'A Bateria Dreantopia Fabulosa contém: 3 tambores, 1 chimbal, 1 par de baquetas, 1 pedestal e vem com suporte para baquetas. Auxilia na coordenação motora e na percepção sonora. Fácil de montar, desmontar e guardar. Vai despertar as habilidades musicais das meninas descoladas, Vem curtir um som! Idade: +3 anos'),
    ('image/dataBaseImageToy/InstrumentoPianoMundoBita.webp', 'Piano e Percussão Mundo Bita', 'Fun', 159.99, 'Piano e Percussão Infantil - Mundo Bita - Fun Divirta-se', 'Piano e Percussao Infantil - Mundo Bita - Fun Divirta-se: Impossivel ficar parado com o Meu Primeiro Piano Mundo Bita! Com ele, as criancas vao poder fazer muito mais do que apenas se familiarizarem com as notas musicais. Multifuncoes, as teclas do piano reproduzem os sons dos animais e ainda as musicas mais conhecidas do Bita, como Fazendinha, Fundo do Mar, Dinossauros e muitas outras. Nos coloridos botoes com diferentes formatos, tambem ha a versao de alguns dos principais hits do personagem de bigode laranja em versao instrumental. Os batuques da conga, timbal e bongo fecham esta aula musical com tipos diferentes de percussao, que podem ser explorados a vontade pelos pequenos.'),
    ('image/dataBaseImageToy/InstrumentoGuitarraEletrica.webp', 'Guitarra Elétrica - Maria Clara e JP', 'Multikids', 120.99, 'Guitarra Elétrica - Maria Clara e o JP - Multikids', 'Junte-se a Maria Clara e o JP nessa aventura musical e cheia de diversão! A guitarra elétrica Maria Clara e JP é uma super guitarra com diversas melodias, luz e som e botões sonoros para ser um(a) guitarrista de verdade! Com correia ajustável que se adapta ao crescimento das crianças. Estimula o aprendizado musical, desenvolvimento cognitivo, motor e criativo.'),
    ('image/dataBaseImageToy/InstrumentoPianoOrquestra.webp', 'Funky o Piano Orquestra', 'Chicco', 307.99, 'Brinquedo Musical - Funky o Piano Orquestra - Chicco', 'Com o Funky, o piano orquestra, as crianças podem descobrir as notas musicais, reconhecer os sons típicos de cada instrumento musical dentro da orquestra e aprender o rítimo das músicas. Um caminho educativo através da música, que vai além dos brinquedos tradicionais! Este piano é um brinquedo evolutivo que segue o crescimento da criança: primeiro, brinque com o piano no chão, depois coloque-o em cima da mesa e continue a brincar até a idade adulta! Possui 2 modos de jogo: 1) Modo orquestra: mova o botão circular e toque em todos os instrumentos musicais na orquestra, um por um ou todos ao mesmo tempo; 2) Modo compositor: ouça as notas musicais e siga as luzes para compor passo a passo todas as melodias.'),
    ('image/dataBaseImageToy/InstrumentoConjuntoMusical.webp', 'Conjunto Musical - PJ Masks', 'Candide', 49.99, 'Conjunto Musical - PJ Masks - Kit Musical', 'PJ Masks - Heróis de Pijama é uma série de desenho animada desenvolvida na Europa e transmitida no Brasil pela Disney Junior! Baseada nos livros "Les Pyjamasques" do autor francês Romuald Racioppo, conta a história de de três crianças de 6 anos de idade: Connor, Amaya e Greg. De dia eles são vizinhos, colegas de classe e melhores amigos. Mas à noite eles estão prontos para viver incríveis aventuras como Menino Gato, Corujita e Lagartixo! Veja como esses pequenos corajosos combatem o crime, lutam contra vilões, enquanto aprendem lições valiosas! Juntos, eles são o PJ Masks, e estão prontos para salvar a cidade! O Conjunto Musical - PJ Masks - Kit Musical da Candide é ideal para auxiliar no desenvolvimento da coordenação motora, da audição, da sensibilidade musical e da interação social da molecada!'),
    ('image/dataBaseImageToy/InstrumentoMesaMusical.webp', 'Mesa de atividades Musical', 'Fun', 184.99, 'Mesa de atividades Musical - Mundo Bita - Branca', 'Luz, sons e muita música para desenvolver a visão, audição e estimular coordenação motora do bebê. A Mesa de Atividades Musical Mundo Bita Fun Divirta-se foi desenvolvida especialmente para incentivar os pequenos a explorar os sentidos de forma divertida, por meio das luzes, sons e peças para encaixar, girar e tocar à vontade! Criada para ser 2 em 1, a mesa interativa pode ser pendurada no berço, com suas alças. Ou ser utilizada no chão, pois acompanha pezinhos removíveis, fáceis de acoplar e guardar. O produto requer 2 pilhas AA, não inclusas. Indicado para crianças com mais de 3 anos.');

INSERT INTO category_table (category_name, category_image) VALUES ( 'Instrumentos Musicais','image/dataBaseImageCategory/Instrumentos.png');




INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/bicicleta-Aro-20-Caloi-Amarelo.webp', 'Bicicleta - Aro 20 - Caloi', 'Caloi', 789.99, 'Bicicleta - Aro 20 - Caloi - Snap - Amarelo', 'Snap é uma bike para meninos que gostam de se divertir pedalando com os amigos, pelos parques e ciclovias. Com novo grafismo, possui freios V-Brake e suspensão dianteira.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Bicicleta-Aro-16-Princesas-Nathor-Rosa-0.webp', 'Bicicleta - Aro 16', 'Nathor', 619.99, 'Bicicleta - Aro 16 - Princesas - Nathor - Rosa', 'BICICLETA ARO 16 PRINCESAS - equipada com os melhores itens de segurança e conforto para crianças. A garotada irá viver grandes aventuras com a bicicleta da Princesas. O produto possui ARO 16, quadro feito em aço carbono, FREIOS V-BRAKE, pneu BORRACHA, e suporta até 30 kilos. Acompanha cestinha.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Bola-Campo-Bravo-XXIII-Penalty-Branco-Cambuci-0.webp', 'Bola Campo Bravo XXIII', 'Penalty', 94.99, 'Bola Campo Bravo XXIII - Penalty - Branco - Cambuci', 'A Penalty criou a Bola Campo Penalty Bravo XXIII, modelo ideal para seus treinos e partidas com os amigos. Desenvolvida com laminado em PÚ, a bola apresenta um ótimo nível de performance durante a utilização. Seu design é elegante e inovador, proporcionando mais credibilidade na hora das partidas. Marque um golaço com a bola dos gramados naturais Bravo! Benefícios: Resistência durante o uso. Performance e credibilidade nas partidas. Alguns diferenciais técnicos: A Bola Campo Penalty Bravo XXIII conta com a tecnologia Câmara 6D que proporciona equilíbrio total para a bola, pois conta com 6 discos posicionados simetricamente. Além de Dupla Colagem, onde recebem uma dupla camada de colagem, reforçando ainda mais a junção dos gomos e garantindo a vida útil da bola por muito mais tempo.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Bola-de-Basquete-Streetball-Laranja-Spalding-Tamanho-7-0.webp', 'Bola de Basquete - Streetball', 'Spalding', 99.99, 'Bola de Basquete - Streetball - Laranja - Spalding - Tam 7', 'Conheça a bola de Basquete Spalding Streetball! Esse produto possui tamanho 7 e é a bola ideal para basquete outdoor em ruas, parques e quadras de cimento em geral, graças ao seu revestimento em Borracha durável e com pontos elevados para boa aderência às mãos. Performance e durabilidade você encontra em sua Spalding!');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Patinete-Dobravel-Jurassic-World-Froes-Laranja-0.webp', 'Patinete Dobrável', 'Froes', 244.99, 'Patinete Dobrável - Jurassic World - Froes - Laranja', 'Patinete 2 Rodas Infantil Jurassic World T-REX - Jurassic World - Patinete 2 Rodas - Froes');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Patinete-pj-masks-br1311-0.webp', 'Patinete - Pj Masks', 'MultiKids', 179.99, 'Patinete - Pj Masks - 3 Rodas - Regulável - Multikids', 'PJ MASKS SÃO TRÊS SUPER HERÓIS QUE COMBATEM OS VILÕES E APRENDEM LIÇÕES VALIOSAS A CADA MISSÃO! PATINETE FLASH PJ MASKS ESPORTE E DIVERSÃO PODEM ANDAR JUNTOS SEMPRE.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Skate-Jurassic-World-Raptor-Froes-Cinza-0.webp', 'Skate - Jurassic World', 'Froes', 244.99, 'Skate - Jurassic World - Raptor - Froes - Cinza', 'Skate Infantil Jurassic World Raptor, foi pensado para as crianças que estão sempre em busca de novas formas de se divertir e brincar. Com Shape Maple 31, trucks feitos em alumínio, rolamentos ABEC 5 além de contar com uma linda estampa de Jurassic World. Feito em material resistente, o Skate é um ótimo presente para as crianças que gostam de esportes radicais sem deixar de lado a segurança. Informações Técnicas:• SHAPE MAPLE 31’’ Informações Técnicas: • TRUCKS EM ALUMINIO REFORÇADO • RODAS 50MM / 30MM PU • ROLAMENTO ABEC 5 • INMETRO');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Skate-Jurassic-World-Dominion-Froes-Cinza-0.webp', 'Skate - Jurassic World', 'Froes', 244.99, 'Skate - Jurassic World - Dominion - Froes - Cinza', 'Skate Infantil Jurassic World Dominion, foi pensado para as crianças que estão sempre em busca de novas formas de se divertir e brincar. Com Shape Maple 31, trucks feitos em alumínio, rolamentos ABEC 5 além de contar com uma linda estampa de Jurassic World. Feito em material resistente, o Skate é um ótimo presente para as crianças que gostam de esportes radicais sem deixar de lado a segurança. Informações Técnicas: • SHAPE MAPLE 31’’ • TRUCKS EM ALUMINIO REFORÇADO • RODAS 50MM / 30MM PU • ROLAMENTO ABEC 5 • INMETRO');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Patins-Classico-Ajustavel-Unicornio-M-Rosa-Astro-Toys-0.webp', 'Patins Clássico Ajustável', 'Astro Toys', 269.99, 'Patins Clássico Ajustável - Unicórnio - M - Rosa - Astro Toys', 'Com o tema unicórnio este patins quad possui o equilíbrio ideal entre um design incrível, alto nível de conforto e fechos de fivela facilmente ajustáveis. Com quatro rodas roxas em PVC de alta qualidade, este patins é projetado para acompanhar o crescimento da criança ajustando-se ao tamanho dos pés. O tamanho M refere-se ao tamanho 35 a 38.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Patins-Classico-Ajustavel-Unicornio-M-Rosa-Astro-Toys-0.webp', 'Patins - Barbie - Ajustável', 'Fun', 269.99, 'Patins - Barbie - Ajustável - Tamanho 33 a 36 - Fun - Rosa', 'O patins in-line do tema da Barbie proporciona uma brincadeira muito divertida e com momentos de descobertas para a criança. É ajustável, garantindo comodidade, segurança e estabilidade à criança enquanto patina. Este patins está disponível no tamanho 33 a 36 e não acompanha acessórios. Idade: + 6 anos.');

INSERT INTO category_table (category_name, category_image) VALUES ('Esportes', 'image/dataBaseImageCategory/icone-esporte.jpg');


INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Charmander.webp', 'Boneco Funko POP! Pokémon - Charmander ', 'Candide', 134.99, 'Boneco Funko POP! Pokémon - Charmander', 'Seu sonho de se tornar um Treinador está ao seu alcance! Capture este Boneco Funko Pop! do Charmander e acrescente-o à sua coleção de Pokémon. Esta figura colecionável tem aproximadamente 10 centímetros de altura e é um item essencial para os fãs da série, trazendo um pedaço do emocionante mundo dos Pokémon para sua coleção.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Bulbasaur.webp', 'Boneco Funko Pop - Bulbasaur - Pokemon', 'Candide', 134.99, 'Boneco Funko Pop - Games - Pokemon - Bulbasaur', 'Seu sonho de se tornar um Treinador está ao seu alcance! Capture este Boneco Funko Pop! do Bulbasaur e acrescente-o à sua coleção de Pokémon. Esta figura colecionável tem aproximadamente 10 centímetros de altura e é um item essencial para os fãs da série, trazendo um pedaço do emocionante mundo dos Pokémon para sua própria coleção.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Pikachu.webp', 'Boneco Funko Pop - Pikachu - Pokemon', 'Candide', 134.99, 'Boneco Funko Pop - Games - Pokemon - Pikachu (Waving)', 'Seu sonho de se tornar um Treinador não está longe! Pikachu está acenando para você. Capture este Boneco Funko Pop! do Pikachu e acrescente-o à sua coleção de Pokémon. Esta figura colecionável tem aproximadamente 10 centímetros de altura e é um item essencial para os fãs da série, trazendo um pedaço do emocionante mundo dos Pokémon para sua própria coleção.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Hermione.webp', 'Boneco Funko Pop - Hp - Hermione', 'Candide', 134.99, 'Boneco Funko Pop - Hp - Hp Anniversary - Hermione With Wand', 'Adicione à sua coleção de Harry Potter uma das bruxas mais brilhantes de sua geração, o Boneco Funko Pop! Hermione Granger. Como Ron já afirmou, ele e Harry não durariam dois dias sem ela. Esta figura colecionável tem aproximadamente 10 centímetros de altura e é uma homenagem à inteligência e coragem da Hermione. Não perca a oportunidade de ter esse icônico personagem na sua coleção de Harry Potter!');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Tanjiro.webp', 'Boneco Funko Pop - Animation Tanjiro Kamado - Demon Slayer', 'Candide', 134.99, 'Boneco Funko Pop - Animation - Demon Slayer - Tanjiro Kamado', 'Apenas dois membros da corajosa família Kamado sobreviveram a um terrível ataque demoníaco, e agora Tanjiro e Nezuko estão determinados a buscar vingança. Amplie sua coleção de Demon Slayer com o Boneco Funko Pop! Tanjiro Kamado. Esta figura de vinil, com aproximadamente 11 centímetros de altura, retrata fielmente esse personagem em sua busca por justiça');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Nezuko.webp', 'Mini Boneca Colecionável Nezuko Kamado - Funko Pop Animation', 'Candide', 149.99, 'Mini Boneca Colecionável - Funko Pop Animation - Demon Slayer - Nezuko Kamado - Candide', 'Apenas dois membros da família Kamado sobreviveram a um ataque de demônios, e agora Tanjiro e Nezuko estão em busca de vingança. Amplie sua coleção de Demon Slayer com Boneco Funko POP! Nezuko Kamado. A figura de vinil tem aproximadamente 13cm de altura.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Midoriya.webp', 'Boneco Izuku Midoriya', 'Uatari', 204.90, 'Boneco Izuku Midoriya 1140 Glow My Hero Academia - Funko Pop!', 'Celebre o herói em ascensão com o Boneco Izuku Midoriya 1140 Glow da Funko Pop! Este colecionável homenageia o protagonista de My Hero Academia, com detalhes meticulosos que capturam sua determinação e espírito de luta. Além disso, ele brilha no escuro, adicionando um toque especial à sua coleção. Garanta o seu agora e tenha Izuku Midoriya iluminando sua jornada como colecionador.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Mandalorian.webp', 'Boneco Funko Pop - The Mandalorian', 'Candide', 130.99, 'Boneco Funko Pop - Star Wars - The Mandalorian - Candide', 'Com o tempo a linha Pop se tornaria uma enorme obsessão para colecionadores e entusiastas da cultura pop em todo o mundo. E o que explica esse sucesso? Bem, a Funko tem sido inteligente em adquirir licenças de muitas marcas diferentes. Qualquer pessoa que goste de desenhos animados, filmes, histórias em quadrinhos, esportes, celebridades pop provavelmente encontrará um Pop, com o qual se identifica. Então, há um modelo para todos.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Tobi.webp', 'Funko Pop - Animation - Tobi', 'Candide', 149.99, 'Mini Figura - Funko Pop - Animation - Naruto - Shippuden - Tobi - Candide', 'Com o tempo a linha Pop se tornaria uma enorme obsessão para colecionadores e entusiastas da cultura pop em todo o mundo. E o que explica esse sucesso? Bem, a Funko tem sido inteligente em adquirir licenças de muitas marcas diferentes. Qualquer pessoa que goste de desenhos animados, filmes, histórias em quadrinhos, esportes, celebridades pop provavelmente encontrará um Pop, com o qual se identifica. Então, há um modelo para todos.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Funko-Jiraiya.webp', 'Funko Pop Rides Jiraiya', 'Candide', 349.99, 'Funko Pop Rides Naruto Shippuden - Jiraiya on Toad', 'Com o tempo a linha Pop se tornaria uma enorme obsessão para colecionadores e entusiastas da cultura pop em todo o mundo. E o que explica esse sucesso? Bem, a Funko tem sido inteligente em adquirir licenças de muitas marcas diferentes. Qualquer pessoa que goste de desenhos animados, filmes, histórias em quadrinhos, esportes, celebridades pop provavelmente encontrará um Pop, com o qual se identifica. Então, há um modelo para todos.');

INSERT INTO category_table (category_name, category_image) VALUES ('Funko Pop', 'image/dataBaseImageCategory/icone-funko-pop.png');


INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Carrinho-Vai-E-Volta-Estrela-Vermelho-0.webp', 'Carrinho - Vai E Volta', 'Estrela', 34.99, 'Carrinho - Vai E Volta - Estrela - Vermelho', 'Vai e volta funciona com fricção reversa, empurrado para fente depois de andar alguns metros ele da um cavalo de pau e retorna ,Vai e volta é um classico Estrela que está de volta, com uma carcaça mais moderna e atrativa para as crianças de hoje em dia. Além de possuir as mesmas funcionalidades e desempenho de sempre.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Carrinho-de-Controle-Remoto-Thunder-Multikids-Amarelo-0.webp', 'Carrinho de Controle Remoto - Amarelo', 'MultiKids', 157.99, 'Carrinho de Controle Remoto - Thunder - Multikids - Amarelo', 'Simule a experiência de dirigir um carro de verdade! Acelere para valer com Racing Control da Multikids! Possui sensor de gravidade que identifica os movimentos para direita e esquerda e simula direção, pedais no chão com acelerador e ré que funcionam em conjunto. O carrinho alcança até 10 metros de distância! Possui luz de LED nos faróis para deixar a brincadeira ainda mais realista. Carrinho alimentado por 4 pilhas AA não inclusas. Sensor de Gravidade alimentado por 2 pilhas AA não inclusas.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/veiculo-de-controle-remoto-spider-man-candide.webp', 'Veículo de Controle Remoto - Disney - Homem Aranha', 'Candide', 67.99, 'Veículo de Controle Remoto - Disney - Marvel - Ultimate - Spider-Man - Candide', 'O Veículo de Controle Remoto - Disney - Marvel da Candide, vem com um rádio controle de 7 funções par as crianças se divertirem com os personagens favoritos da Marvel. Utiliza 2 pilhas AA no controle e 3 pilhas AA no veículo.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Carrinho-Batman.webp', 'Carro de Controle Remoto - Batman', 'Candide', 109.99, 'Carro de Controle Remoto - Batman - Veículo de Ação - Candide', 'Carro de controle remoto Batman veículo de ação, rádio controle com 3 funções de comando.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Carrinho-de-Controle-Remoto-Racing-Control-Raptor-Vermelho-0.webp', 'Carrinho de Controle Remoto Vermelho - Racing Control', 'MultiKids', 149.99, 'Carrinho de Controle Remoto - Racing Control Raptor - 1:16 – Multikids - Vermelho', 'O Racing Control é um carrinho de controle remoto realista, possui volante com sensor de movimentos, pedais, acelerador e marcha ré. O produto é super estiloso com luz de LED, para iluminar o caminho, deixando a brincadeira ainda mais realista.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Carrinho-e-Acessorios-Senninha-Pit-Stop.webp', 'Carrinho e Acessórios - Senninha', 'Parkitoys', 30.99, 'Carrinho e Acessórios - Senninha - Pit Stop - Parkitoys', 'O Pit stop é um brinquedo que vai trabalhar coordenação motora, imaginação e criatividade da criança. Ele vem com carro de F1, ferramentas e peças para montar. Além de ser um produto muito divertido, ele apoia a Educação, em parceria com o IAS (Instituto Ayrton Senna, todo Royalties dele será revertido no projeto social do Instituto).');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Conjunto-de-Carrinhos-Senninha-Truck-Guincho.webp', 'Conjunto de Carrinhos - Senninha', 'Parkitoys', 110.99, 'Conjunto de Carrinhos - Senninha - Truck Guincho - Parkitoys', 'O Truck Senninha é um brinquedo que vai trabalhar coordenação motora, imaginação e criatividade da criança. Ele vem com carro de F1, ferramentas e peças para montar. Além de ser um produto muito divertido, ele apoia a Educação, em parceria com o IAS (Instituto Ayrton Senna, todo Royalties dele será revertido no projeto social do Instituto)');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Carrinho-Vai-e-Volta-Estrela-Azul-0.webp', 'Carrinho - Vai e Volta Azul', 'Estrela', 34.99, 'Carrinho - Vai e Volta - Estrela - Azul', 'Vai e volta funciona com fricção reversa, empurrado para frente depois de andar alguns metros ele dá um cavalo de pau e retorna, Vai e volta é um clássico Estrela que está de volta, com uma carcaça mais moderna e atrativa para as crianças de hoje em dia. Além de possuir as mesmas funcionalidades e desempenho de sempre.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Carrinho-Patrulha-canina.webp', 'Patrulha Canina - Mini Veículos', 'Sunny', 99.99, 'Patrulha Canina - Mini Veículos True Metal com 3 Peças - Sunny', 'Patrulha Canina - Mini Veículos True Metal com 3 Peças da Sunny É Ideal Para Crianças Acima de 3 Anos. os Heróis da Série de Tv Paw Patrol Também Estão Disponíveis Como Brinquedos de Metal. Veículos True Metal Detalhados em Escala 1:55 com Rodas Giratórias e Poses Dinâmicas Trazem Ação Aos Quartos Das Crianças. Os Ajudantes de Quatro Patas Estão Firmemente Presos Aos Seus Veículos e Não Podem Ser Perdidos. Todos Os Veículos São Feitos de Metal Moldado Por Injeção de Alta Qualidade. Este Conjunto de Presente Paw Patrol É Um Conjunto de 3 Apresentando Skye, Chase e Marshall e Seus Veículos True Metal da Linha Off-Road Pulverizada com Lama. com Detalhes e Designs Autênticos Cobertos de Lama, Rodas Funcionais e Feitos de Metal Fundido, Os Veículos Off-Road Estão Prontos Para Entrar em Ação Num Piscar de Olhos. Os Veículos Podem Ser Empurrados Manualmente e As Rodas Giram com Você. Cada Filhote É Moldado Ao Veículo.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Carrinho-Transformavel-controle-remoto.webp', 'Carrinho Transformável de Controle Remoto - Megaformers - Neptune', 'MultiKids', 144.99, 'Carrinho Transformável de Controle Remoto - Megaformers - Neptune - Multikids - Vermelho', 'Os megaformers são carros de controle remoto que se transformam em robôs. Eles estão preparados para qualquer desafio! Giram 360º, possuem luz de led e a escala é 1:18!');

INSERT INTO category_table (category_name, category_image) VALUES ('Carrinho', 'image/dataBaseImageCategory/icone-carrinho.png');



INSERT INTO category_table (category_name, category_image) VALUES ('HotWheels', 'image/dataBaseImageCategory/HotWheels.jpg');
INSERT INTO category_table (category_name, category_image) VALUES ('Nerf', 'image/dataBaseImageCategory/Nerfs.png');
INSERT INTO category_table (category_name, category_image) VALUES ('Lego', 'image/dataBaseImageCategory/Lego.png');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/HotWheels4.webp', ' Estação Científica Hot Wheels', 'Mattel', 199.99, ' Estação Científica Hot Wheels Color Change', 'Descubra muita diversão com esta Estação Científica, onde loucas experiências com cores podem sair do controle! Um cientista maluco prendeu um carro Color Shifters sob a cachoeira de mudança de cor, e está experimentando todos os tipos de combinações insanas de cores! Você consegue ajudar o carro a escapar? Descubra neste passeio cheio de aventuras! Lance para a ação, correndo com o carro pela pista e liberte-o. Ah não! Parece que o cientista maluco encurralou você! Aperte a alavanca de liberação e solte o carro no tanque abaixo, para que sua cor volte ao normal. As crianças vão adorar a emoção ao tentar escapar do laboratório do cientista maluco, enquanto observam as mais piradas combinações de cores. Vem com três diferentes zonas de mudança de cor, além de um carro Color Shifters, para que as crianças possam se divertir assim que abrirem a caixa.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/HotWheels3.webp', 'Pista Hot Wheels Wave Racers - Fun', 'Mattel', 401.90, 'Pista Hot Wheels Wave Racers Pista Triple Skyloop', 'Acene rápido, para correr rápido! Nesta alucinante pista, ganha quem acenar mais rápido com as mãos, em cima dos carrinhos Hot Wheels! No Hot Wheels - Wave Racers - Triple Sky Loop, posicione os carrinhos dentro da pista, coloque sua mão em cima do sensor e agite de um lado para o outro rapidamente. Os carrinhos são ativados após pelo menos 15 movimentos realizados em 5 segundos. A velocidade dos Hot Wheels vai depender da rapidez dos movimentos. O brinquedo inclui 2 carrinhos movidos por sensores e peças conectáveis, que formam uma pista radical com 3 loops aéreos. O tamanho da pista é de 91 cm por 50 cm, com 26 cm de altura. Cada carrinho requer 2 pilhas AA (não inclusas). Recomendação: 3+');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/HotWheels2.webp', 'Hot Wheels Bandai Chara Wheel Lupin', 'Mattel', 1500.00, 'Hot Wheels Bandai Chara Wheel Lupin Kit c/ 3 carrinhos', 'Hot Wheels Bandai Chara Wheel Lupin O 3º 27 O Castelo de Cagliostro (3 set) O kit contém 3 carrinhos Hot Wheels Bandai Lupin lacrados com blister em perfeitas condições. 1 – Citroen 2cv 1 – Hambersupersnipe 1 – Fiat 500 o japonês “Lupin the third” também conhecido como Lupin terceiro, é uma série de mangá, escrita e ilustrada por Kazuhiko Kato');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/HotWheels1.webp', 'Carrinho Hot Wheels', 'Mattel', 19.99, 'Carrinho Hot Wheels - Veículos Básicos - Sortido', 'JATO D’ÁGUA FORTE: O lançador de água Nerf Super Soaker Rainstorm é ideal para encharcar os amigos com um jato gigante de água; MUITA ÁGUA: O lançador possui um barril que lança um forte jato de água para encharcar os amigos; LANÇAMENTOS CARREGADOS: É só mirar e empurrar a alavanca de carregamento para frente para lançar um poderoso jato de água; FÁCIL DE ENCHER: Fácil de lançar! Basta colocar a ponta do lançador na água e puxar o carregador para encher o reservatório. A capacidade do tanque é de 650 mL; EMBALAGEM ECOLÓGICA. Vem numa embalagem simples, reciclável e de abertura fácil. Muita diversão ao lançar jatos poderosos de água com o lançador de água Nerf Super Soaker Rainstorm. É só mirar e empurrar a alavanca de carregamento para frente para lançar um poderoso jato de água. Fácil de lançar! Basta colocar a ponta do lançador na água e puxar o carregador para encher o reservatório. A capacidade do tanque é de 650 mL. Perfeito para brincar no quintal e em parques ou festas em lugares abertos! A marca Nerf Super Soaker é sinônimo de diversão desde 1989 e continua trazendo muita água para brincadeiras ao ar livre entre amigos! Lançadores Nerf Super Soaker, deixando o verão e os dias quentes ainda mais divertidos. Nerf Super Soaker e todas as propriedades relacionadas são marcas registradas da Hasbro.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Nerf3.webp', 'Lançador de Água - Nerf Super Soaker', 'Hasbro', 117.99, 'Lançador de Água - Nerf Super Soaker - Rainstorm - Capacidade 650ml', 'Posso Trocar Este Produto em uma Loja Física? Sim, exceto para produtos exclusivos do e-commerce. Código de Barras 5010993974788 Restrição de Idade: Não recomendável para menores de 3 anos por conter peças pequenas que podem ser engolidas. Código do Fabricante: F3890 Aviso: As cores podem variar entre as imagens mostradas acima e o produto. Imagens meramente ilustrativas. Certificado: Certificado pelos Órgãos Autorizados - OCPS (Organismos de Certificação de Produtos) Peso: 0.400 Kg Dimensões (AxLxC): Tamanho (LAP): 35 x 12 x 2 cm Referência do Fabricante HASBRO Produto Certificado: IFBQ IQB 003784/2022 Itens Inclusos: 1 lançador.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Nerf2.webp', 'Lança Dardos - Nerf - Dinosquad Terrodak Elite', 'Hasbro', 167.99, 'Lança Dardos - Nerf - Dinosquad Terrodak Elite - 12 Dardos', 'LANÇADOR NERF DINOSQUAD TERRODAK: Grandes aventuras ao ar livre com o lançador Nerf com design inspirado em pterodáctilo; LANÇA 4 DARDOS: O lançador Nerf DinoSquad Terrodak lança 4 dardos seguidos. Muita diversão com o lançador com tema de dinossauro; 12 DARDOS DE ESPUMA NERF: Inclui 12 dardos de espuma Nerf Elite. Basta carregar 4 dardos e reservar os 8 restantes para uma recarga rápida. Excelente brinquedo para meninos e meninas brincarem ao ar livre; PORTA-DARDOS: O porta-dados ajuda na rápida recarga do brinquedo. Muitas aventuras com o lançador com tema de dinossauro; BOMBEAR E LANÇAR: Fácil de usar. Basta inserir os 4 dardos no tubo frontal, mover o carregador para traz e para frente para preparar o lançador e apertar a alavanca de disparo para lançar 1 dardo. Membro de elite lendários DinoSquad! Muitas aventuras com a grande força dos dinossauros com este lançador Nerf com design inspirado em pterodáctilo para brincadeiras ao ar livre. O lançador Nerf DinoSquad Terrodak lança 4 dardos seguidos. Muita diversão com o lançador com tema de dinossauro. Inclui 12 dardos de espuma Nerf Elite. Basta carregar 4 dardos e reservar os 8 restantes para uma recarga rápida. Excelente brinquedo para meninos e meninas brincarem ao ar livre. O porta-dados ajuda na rápida recarga do brinquedo. Muitas aventuras com o lançador com tema de dinossauro. Fácil de usar. Basta inserir os 4 dardos no tubo frontal, mover o carregador para traz e para frente para preparar o lançador e apertar a alavanca de disparo para lançar 1 dardo. Recomenda-se o uso de óculos (não incluídos). Não requer pilhas.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Nerf1.webp', 'Lançador de Dardos - Nerf Elite 2.0', 'Hasbro', 229.99, 'Lançador de Dardos - Nerf Elite 2.0 - EAGLEPOINT', 'Posso Trocar Este Produto em uma Loja Física? Sim, exceto para produtos exclusivos do e-commerce. Código de Barras 195166187198 Restrição de Idade: Não recomendável para menores de 3 anos por conter peças pequenas que podem ser engolidas. Código do Fabricante: F0424 Aviso: As cores podem variar entre as imagens mostradas acima e o produto. Imagens meramente ilustrativas. Certificado: Certificado pelos Órgãos Autorizados - OCPS (Organismos de Certificação de Produtos) Peso: 0.877 Kg Dimensões (AxLxC): Tamanho (LAP): 28 x 26 x 7 cm Referência do Fabricante HASBRO Produto Certificado: IQB - CE-BRI/IQB-005128 - NM 300/2002 - OCP 006 Itens Inclusos: LANÇADOR E 16 DARDOS');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Lego1.webp', 'Lego Star Wars Pack Soldado Clone e Droide', 'Lego', 280.00, 'Lego Star Wars Pack Soldado Clone e Droide 75372 215pcs', 'Lego Star Wars Pack Soldado Clone e Droide 75372 215pcs Marca: LEGO Linha: Star Wars Modelo: Pack Soldado Clone e Droide Quantidade de Peças: 215 Idade Recomendada: 7+ Material: Plástico Conteúdo da Embalagem: Peças e Manual de Montagem Ilustrado Número do Certificado do INMETRO: CE-BRI/INNAC 001205-05A Interação entre pai e filho. Desenvolvimento da coordenação motora fina, foco, trabalho em equipe, colaboração. Potencializa o desenvolvimento da imaginação, criatividade, comunicação. Estimula a afetividade, socialização e as competências socioemocionais. Atenção! Perigo de asfixia. Peças pequenas.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Lego2.webp', 'Lego Ninjago Robo De Combate Do Arin', 'Lego', 149.99, 'Lego Ninjago Robo De Combate Do Arin 71804 104pcs', 'Lego Ninjago Robo De Combate Do Arin 71804 104pcs Marca: LEGO Linha: Ninjago Modelo: Robo De Combate Do Arin Quantidade de Peças: 104 Idade Recomendada: 4+ Material: Plástico Conteúdo da Embalagem: Peças e Manual de Montagem Ilustrado Número do Certificado do INMETRO: CE-BRI/INNAC 001205-05A Interação entre pai e filho. Desenvolvimento da coordenação motora fina, foco, trabalho em equipe, colaboração. Potencializa o desenvolvimento da imaginação, criatividade, comunicação. Estimula a afetividade, socialização e as competências socioemocionais. Atenção! Perigo de asfixia. Peças pequenas.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/Lego3.webp', 'Lego City Carro de Corrida Verde', 'Lego', 99.99, 'Lego City Carro de Corrida Verde 60399 56pcs', 'Lego City Carro de Corrida Verde 60399 56pcs Marca: LEGO Linha: City Modelo: Carro de Corrida Verde Quantidade de Peças: 56 Idade Recomendada: 4+ Material: Plástico Conteúdo da Embalagem: Peças e Manual de Montagem Ilustrado Número do Certificado do INMETRO: CE-BRI/INNAC 001205-05A Interação entre pai e filho. Desenvolvimento da coordenação motora fina, foco, trabalho em equipe, colaboração. Potencializa o desenvolvimento da imaginação, criatividade, comunicação. Estimula a afetividade, socialização e as competências socioemocionais. Atenção! Perigo de asfixia. Peças pequenas.');


INSERT INTO toy_category (toy_code_fk, category_code_fk) 
VALUES 
   (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1),
   (7, 2), (8, 2), (9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2), 
   (15, 3), (16, 3), (17, 3), (18, 3), (19, 3), (20, 3), (21, 3), (22, 3), (23, 3), (24, 3), 
   (25, 4), (26, 4), (27, 4), (28, 4), (29, 4), (30, 4), (31, 4), (32, 4), (33, 4),
   (34, 5), (35, 5), (36, 5), (37, 5), (38, 5), (39, 5), (40, 5), (41, 5), (42, 5), (43, 5),
   (44, 6), (45, 6), (46, 6), (47, 6), (48, 6), (49, 6), (50, 6), (51, 6), (52, 6), (53, 6), 
   (54, 7), (55, 7), (56, 7), (57, 7), (58, 7), (59, 7), (60, 7), (61, 7), (62, 7), (63, 7),
   (64, 8), (65, 8), (66, 8), (67, 8),
   (68, 9), (69, 9), (70, 9), 
   (71, 10), (72, 10), (73, 10);




INSERT INTO user_table (user_name, user_email, user_password) 
VALUES ('admin', 'admin@admin', 'admin');
