# DataBehavior - Plugin Design Document (PDD)

**Versão do Documento:** 1.0
**Data:** 2025-10-07
**Autor:** Gemini (em colaboração com Bruno)

---

## 1. Visão Geral e Filosofia

### 1.1. Conceito

O **DataBehavior** é um plugin para Godot Engine 4.x, parte da suíte CafeEngine, projetado para gerenciar e estruturar dados de jogo de forma modular e reutilizável através de Resources. Ele estende a filosofia de Programação Orientada a Resources (ROP), permitindo que os desenvolvedores definam e organizem dados complexos do seu jogo como Resources.

### 1.2. Filosofia

-   **Dados como Resources:** Todos os dados de jogo (estatísticas de itens, configurações de inimigos, dados de níveis, etc.) são tratados como `Resource`s, aproveitando a serialização e a integração nativa do Godot.
-   **Modularidade:** Separação clara entre dados e lógica de comportamento, promovendo sistemas mais flexíveis e fáceis de manter.
-   **Edição no Inspector:** Permite que designers e desenvolvedores editem e ajustem os valores dos dados diretamente no Inspector do Godot, sem a necessidade de codificação.
-   **Reutilização:** Facilita o compartilhamento e a reutilização de conjuntos de dados entre diferentes entidades e sistemas do jogo.

### 1.3. Política de Versão e Compatibilidade

-   **Versão Alvo:** O DataBehavior tem como alvo inicial o **Godot 4.5**.
-   **Compatibilidade Futura:** O projeto será ativamente mantido para garantir compatibilidade com versões futuras do Godot 4.x.
-   **Retrocompatibilidade:** Não haverá suporte para versões anteriores ao Godot 4.5, a fim de aproveitar os recursos mais recentes da engine e manter uma base de código limpa e moderna.

---

## 2. Arquitetura Principal

O sistema é composto por:

### 2.1. `DataManager` (O Gerenciador de Dados)

-   **Tipo:** `Node` (Autoload Singleton).
-   **Função:** Atua como um ponto de acesso global para todos os dados do jogo. Ele pode carregar, armazenar e fornecer acesso a `DataResource`s.
-   **Funcionalidades Planejadas:**
    -   Carregamento assíncrono de dados.
    -   Gerenciamento de diferentes conjuntos de dados (ex: `WeaponData`, `MoveData`, `GameStateData`).
    -   (Futuro) Validação de dados.

### 2.2. `DataResource` (A Base para Dados)

-   **Tipo:** `Resource`.
-   **Função:** Classe base abstrata para todos os recursos de dados específicos do jogo. Ele pode conter propriedades exportadas para serem configuradas no Inspector.
-   **Exemplos de Implementação:**
    -   `WeaponData`: Contém propriedades como `damage`, `attack_speed`, `range`.
    -   `MoveData`: Contém propriedades como `speed`, `acceleration`, `jump_height`.
    -   `GameStateData`: Contém propriedades como `level_name`, `player_start_position`, `enemy_spawn_points`.

---

## 3. Estrutura de Arquivos Proposta

```
addons/data_behavior/
├── plugin.cfg
├── components/
│   └── data_manager.gd
├── resources/
│   ├── data_config.tres
│   └── data_resources/ # Subpasta para todos os DataResources (recursos)
│       ├── data_resource.gd
│       ├── weapon_data.gd
│       ├── move_data.gd
│       └── game_state_data.gd
├── panel/
│   ├── data_panel.gd
│   └── data_panel.tscn
├── scripts/
│   └── editor_plugin.gd
└── icons/
    └── data_icon.svg
```

---

## 4. Plano de Desenvolvimento em Fases

### Fase 1: Fundação (MVP - Minimum Viable Product)

-   [ ] **Criar Script Base:** Implementar `data_resource.gd` como a classe base para todos os recursos de dados.
-   [ ] **Criar `DataManager`:** Implementar `data_manager.gd` como um autoload singleton.
-   [ ] **Criar Recursos de Dados de Exemplo:** Desenvolver `WeaponData`, `MoveData` e `GameStateData` como prova de conceito.
-   **Objetivo:** Ter um sistema funcional para definir e acessar dados de jogo através de Resources.

### Fase 2: Integração como Plugin Godot e Melhorias no Inspector

-   [ ] **Criar `plugin.cfg`:** Definir o plugin para o Godot.
-   [ ] **Implementar `editor_plugin.gd`:**
    -   Registrar `DataResource` e seus derivados como tipos customizados com ícones próprios.
    -   Adicionar uma opção no menu `Create Resource` para facilitar a criação de `DataResource`s.
-   [ ] **Inspector Aprimorado:** Utilizar `_get_property_list()` nos `DataResource`s para organizar propriedades em categorias.
-   **Objetivo:** Transformar o sistema em um plugin fácil de instalar e usar, com melhor clareza no Inspector.

### Fase 3: Painel de UI e Ferramentas de Depuração

-   [ ] **Criar `data_panel.tscn` e `data_panel.gd`:** Desenvolver a UI principal do plugin, que será docada no editor.
-   [ ] **Funcionalidades do Painel:**
    -   Visualizar e gerenciar os `DataResource`s carregados.
    -   Ferramentas para criar e editar `DataResource`s.
-   **Objetivo:** Fornecer feedback visual e ferramentas que acelerem o desenvolvimento e a depuração de dados de jogo.

### Fase 4: Documentação e Exemplos

-   [ ] **Documentar o Código:** Adicionar comentários claros em todas as classes e funções principais.
-   [ ] **Criar Documentação Externa:** Escrever guias no formato Markdown na pasta `docs/` do plugin.
-   [ ] **Criar um Projeto Demo Completo:** Montar um pequeno jogo ou cena de exemplo que utilize diversos `DataResource`s.
-   **Objetivo:** Garantir que o plugin seja acessível e fácil de aprender para novos usuários.

---

## 5. Considerações Futuras (Pós-MVP)

-   **Validação de Dados:** Ferramentas para validar a integridade e consistência dos dados.
-   **Editor Visual de Dados:** Uma ferramenta visual para criar e gerenciar relações entre `DataResource`s.
-   **Integração com Outros Plugins:** Sinergia com outros plugins da suíte CafeEngine (ex: `StateCafe` usando `MoveData`).
