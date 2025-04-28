# Rick and Morty Explorer

Um aplicativo Flutter que consome a [Rick and Morty API](https://rickandmortyapi.com/), permitindo autenticação de usuário (Firebase Auth) e salvando personagens favoritos no Cloud Firestore.

## Pré-requisitos

- Flutter (>=3.0)
- Dart SDK (>=2.17)
- Conta no Firebase
- FlutterFire CLI instalado:
  ```bash
  dart pub global activate flutterfire_cli
  ```

---

## Configuração do Firebase

Antes de executar o projeto, você precisa gerar/configurar dois arquivos essenciais usando o FlutterFire CLI:

1. **google-services.json**
   - Local: `/android/app/google-services.json`
   - Gere via FlutterFire CLI:
     ```bash
     flutterfire configure \
       --project "<SEU_FIREBASE_PROJECT_ID>" \
       --out "lib/firebase_options.dart"
     ```
   - Esse comando também gerará o próximo arquivo.

2. **firebase_options.dart**
   - Local: `/lib/firebase_options.dart`
   - Contém as configurações do Firebase para cada plataforma.


## Instalação e Execução

1. Clone o repositório:
   ```bash
   git clone https://github.com/gabrielassed/dsdm1_rick_and_morty.git
   cd dsdm1_rick_and_morty
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

3. Gere as configurações do Firebase (caso não tenha feito):
   ```bash
   flutterfire configure \
     --project "<SEU_FIREBASE_PROJECT_ID>" \
     --out "lib/firebase_options.dart"
   ```

4. Execute no dispositivo/emulador:
   ```bash
   flutter run
   ```

---

## Demonstração

> [Baixar o APK](#)

![App GIF](assets/demo.gif)