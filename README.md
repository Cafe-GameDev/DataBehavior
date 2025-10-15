# DataBehavior - Plugin Design Document (PDD)

[![DataBehavior](https://img.shields.io/badge/DataBehavior-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

**Versão do Documento:** 1.0
**Data:** 2025-10-14
**Autor:** Café GameDev

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **DataBehavior** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar dados de jogo de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem dados complexos do seu jogo (como estatísticas de armas, configurações de movimento de personagens, ou dados de estados de jogo) como Resources.

### 1.2. Filosofia Central

*   **Dados como Resources:** Todos os dados de jogo são tratados como `Resource`s, aproveitando a serialização e a integração nativa do Godot. Isso promove a edição no Inspector, reuso e manutenção.
*   **Modularidade:** Separação clara entre dados e lógica de comportamento, promovendo sistemas mais flexíveis e fáceis de modificar.
*   **Edição Visual:** Integração com o `BlueprintEditor` para permitir a visualização e manipulação gráfica de `DataResource`s, facilitando a criação de sistemas de dados complexos.

### 1.3. Política de Versão e Compatibilidade

*   **Versão Alvo:** Godot 4.5+
*   **Compatibilidade:** Mantida com versões futuras da série 4.x.
*   **Retrocompatibilidade:** Nenhum suporte a versões anteriores a 4.5, garantindo código moderno e limpo.

---

## 2. Arquitetura Central

O sistema DataBehavior é composto por elementos que facilitam a gestão de dados.

### 2.1. Componentes Principais

*   **`DataManager` (Autoload Singleton):** Um `Node` que atua como um ponto de acesso global para todos os dados do jogo. Ele pode carregar, armazenar e fornecer acesso a `DataResource`s.
*   **`DataResource` (Base Class):** A classe base abstrata para todos os recursos de dados específicos do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
*   **`DataBottomPanel`:** Um painel ancorado na parte inferior do editor, utilizado para listar, gerenciar e criar `DataResource`s e seus scripts associados.
*   **`DataPanel` (SidePanel):** Um painel lateral compacto, principalmente para acesso rápido à documentação e configurações gerais do plugin.

---

## 3. Estrutura de Arquivos Padrão

```
addons/data_behavior/
├── plugin.cfg
├── components/
│   └── data_behavior.gd
├── resources/
│   ├── data_config.tres
│   └── data_resources/ # Subpasta para todos os DataResources (recursos)
│       ├── data_resource.gd
│       └── [outros_data_resources].gd
├── panel/
│   ├── data_bottom_panel.gd
│   ├── data_bottom_panel.tscn
│   ├── data_panel.gd
│   └── data_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── [icones].svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP)

*   [x] **`DataResource`:** Implementar a classe base para todos os recursos de dados.
*   [x] **`DataManager`:** Implementar o `data_behavior.gd` como um autoload singleton.
*   [x] **`DataBottomPanel`:** Criar o painel inferior para gerenciamento de `DataResource`s.
*   [x] **`DataPanel`:** Criar o SidePanel para acesso à documentação e configurações.
*   **Objetivo:** Ter um sistema funcional para definir, acessar e gerenciar dados de jogo através de Resources no editor.

### Fase 2: Integração e Melhorias no Editor

*   [ ] **`plugin.cfg`:** Definir o plugin para o Godot.
*   [ ] **`editor_plugin.gd`:** Registrar `DataResource` e seus derivados como tipos customizados com ícones próprios e configurar o autoload.
*   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `DataResource`s para organizar propriedades em categorias.
*   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Edição Visual e Ferramentas de Depuração

*   [ ] **Integração com `BlueprintEditor`:** Desenvolver a funcionalidade para que o `BlueprintEditor` possa visualizar e manipular `DataResource`s graficamente.
*   [ ] **Validação de Dados:** Implementar ferramentas para validar a integridade e consistência dos dados.
*   [ ] **Ferramentas de Criação:** Melhorar as ferramentas de criação de `DataResource`s e scripts associados.
*   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de dados de jogo.

### Fase 4: Documentação e Exemplos

*   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
*   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
*   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversos `DataResource`s.
*   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Padrões de Qualidade de Código

*   Todos os scripts de Resource e Editor devem usar `@tool`.
*   Classes documentadas com docstring.
*   Sinais seguem convenção: `changed`, `updated`, `requested`, `completed`.
*   Nenhum Resource deve depender diretamente de Nodes (exceto para referências de `owner` em `StateBehavior`s, por exemplo).

---

## 6. Considerações Futuras

*   **Editor Visual de Dados:** Uma ferramenta visual mais avançada para criar e gerenciar relações complexas entre `DataResource`s.
*   **Geração Automática:** Ferramentas para gerar `DataResource`s a partir de fontes externas (ex: CSV, JSON).

---

## Instalação

1.  **AssetLib (Recomendado):**
    *   Procure por "DataBehavior" na Godot Asset Library e instale o plugin.
2.  **Manual (GitHub):**
    *   Baixe o repositório.
    *   Copie a pasta `addons/data_behavior` para a pasta `addons/` do seu projeto.

Após a instalação, vá em `Project -> Project Settings -> Plugins` e ative o plugin **DataBehavior**.

## Contribuição

Este projeto é open-source e contribuições são bem-venidas! Por favor, leia nosso [guia de contribuição](../../CONTRIBUTING.md) para saber como reportar bugs, sugerir funcionalidades e submeter pull requests.

## Licença

Este projeto é distribuído sob a Licença MIT. Veja o arquivo [LICENSE](../../LICENSE) para mais detalhes.