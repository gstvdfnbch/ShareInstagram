# Instagram Stories Sharing (iOS – Nativo)

Este projeto demonstra como realizar **compartilhamento para Instagram Stories de forma nativa no iOS**, sem SDKs externos, utilizando apenas APIs do sistema (`UIKit`) e o **Facebook App ID**.

https://github.com/creme-tech/creme-sharing
https://developers.facebook.com/docs/instagram-platform/sharing-to-stories
https://pub.dev/packages/appinio_social_share

---

## 📌 Conceito Geral

O Instagram **não fornece um SDK público** para compartilhamento em Stories no iOS.  
Em vez disso, o fluxo oficial funciona através de:

- **URL Schemes** (deep links)
- **UIPasteboard** (área de transferência entre apps)
- Um **Facebook App ID** válido

O aplicativo prepara os dados (imagem, cores, etc.), coloca esses dados no `UIPasteboard` e então abre o Instagram via um deep link específico.  
O Instagram, ao abrir, lê os dados do `UIPasteboard` e monta o Story.

---

## 🆔 O que é o Facebook App ID

O **Facebook App ID** é um identificador único gerado ao criar um app no **Meta for Developers**.

Ele é obrigatório para:
- Compartilhamento para **Instagram Stories**
- Identificação da origem do conteúdo

O Instagram utiliza esse ID para validar **qual aplicativo está solicitando o compartilhamento**.

---

## 📍 Onde obter o App ID

1. Acesse o painel de desenvolvedor da Meta  
   https://developers.facebook.com
2. Clique em **“Meus Apps”**
3. Crie um novo app ou selecione um existente
4. Vá em **Configurações → Básico**
5. Copie o valor exibido como **App ID**

Exemplo de App ID:

```
1156927169939216
```

---

## 🔗 Como o App ID é utilizado

O App ID deve ser passado como parâmetro no deep link de abertura dos Stories:

```swift
instagram-stories://share?source_application=SEU_FACEBOOK_APP_ID
```

Exemplo real:

```swift
instagram-stories://share?source_application=1156927169939216
```

Sem esse parâmetro:
- O Instagram pode **ignorar a requisição**
- O compartilhamento pode **falhar silenciosamente**

---

## 🧠 Como o compartilhamento para Stories funciona

### Fluxo completo

```
Seu App
  ↓
Cria imagem (UIImage)
  ↓
Escreve dados no UIPasteboard
  ↓
Abre instagram-stories://
  ↓
Instagram lê o Pasteboard
  ↓
Story é montado pelo usuário
```

---

## 🛠 O que foi implementado neste projeto

### 1️⃣ Preparação da imagem

A imagem usada no Story é carregada a partir dos **Assets do app**:

```swift
UIImage(named: "image")
```

Essa mesma imagem pode ser reutilizada para outros tipos de compartilhamento.

---

### 2️⃣ Escrita no UIPasteboard

Os dados são enviados ao Instagram usando chaves oficiais:

```swift
let pasteboardItems: [String: Any] = [
    "com.instagram.sharedSticker.stickerImage": pngData,
    "com.instagram.sharedSticker.backgroundTopColor": "#FFCC00",
    "com.instagram.sharedSticker.backgroundBottomColor": "#FF8800"
]
```

Essas chaves são lidas automaticamente pelo Instagram ao abrir.

---

### 3️⃣ Abertura do Instagram Stories

Após escrever no `UIPasteboard`, o app abre o Instagram:

```swift
let urlString = "instagram-stories://share?source_application=1156927169939216"
UIApplication.shared.open(URL(string: urlString)!)
```

O Instagram então:
- Lê os dados do pasteboard
- Exibe o Story para o usuário
- Permite edição e publicação manual

---

## ⚙️ Configurações obrigatórias no iOS

### `Info.plist`

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>instagram</string>
    <string>instagram-stories</string>
</array>
```

Para compartilhamento no Feed (salvar imagem):

```xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Precisamos salvar imagens para compartilhar no Instagram</string>
```

---

## ⚠️ Observações importantes

- ❌ Não funciona no Simulator
- ✅ Funciona apenas em iPhone físico
- ❌ Não é possível postar automaticamente
- ✅ Método aceito pela App Store
- ⏱ Dados no `UIPasteboard` expiram automaticamente

---

## 📦 Conclusão

Este projeto demonstra a **forma oficial e nativa** de compartilhar conteúdo para Instagram Stories no iOS:

- Sem SDKs externos
- Sem dependências
- Total controle do fluxo
- Compatível com SwiftUI, UIKit e Flutter (via plugin)

O Flutter, quando usado, atua apenas como **ponte**, enquanto toda a lógica real acontece no código nativo iOS.
