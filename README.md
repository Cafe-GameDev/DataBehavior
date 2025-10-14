# 📊 DataBehavior

[![DataBehavior](https://img.shields.io/badge/DataBehavior-v1.0.0-478cbf?style=for-the-badge)](https://www.cafegame.dev/pt-BR/cafeengine)
[![License](https://img.shields.io/badge/License-MIT-f1c40f?style=for-the-badge)](https://opensource.org/licenses/MIT)

**DataBehavior** é um plugin para Godot 4.x, parte da suíte CafeEngine, focado em gerenciar e estruturar dados de jogo de forma modular e reutilizável através de Resources.

## Visão Geral

O DataBehavior estende a filosofia de Programação Orientada a Resources (ROP) da CafeEngine, permitindo que você defina e organize dados complexos do seu jogo (como estatísticas de armas, configurações de movimento de personagens, ou dados de estados de jogo) como Resources. Isso facilita a edição no Inspector do Godot, a reutilização em diferentes partes do seu projeto e a manutenção.

## Principais Funcionalidades

*   **Dados Orientados a Resources:** Crie, configure e gerencie todos os seus dados de jogo como Resources, aproveitando a serialização e a integração nativa do Godot.
*   **Modularidade:** Separe a lógica do comportamento dos dados, permitindo que seus sistemas sejam mais flexíveis e fáceis de modificar.
*   **Edição no Inspector:** Edite e ajuste os valores dos seus dados diretamente no Inspector do Godot, sem a necessidade de codificação.
*   **Reutilização:** Compartilhe e reutilize conjuntos de dados entre diferentes entidades e sistemas do seu jogo.

## Documentação

A documentação completa, com guias detalhados, tutoriais e a referência da API, pode ser encontrada no nosso site oficial:

[https://www.cafegame.dev/cafeengine/databehavior](https://www.cafegame.dev/cafeengine/databehavior)

## Instalação

1.  **AssetLib (Recomendado):**
    *   Procure por "DataBehavior" na Godot Asset Library e instale o plugin.
2.  **Manual (GitHub):**
    *   Baixe o repositório.
    *   Copie a pasta `addons/databehavior` para a pasta `addons/` do seu projeto.

Após a instalação, vá em `Project -> Project Settings -> Plugins` e ative o plugin **DataBehavior**.

## Contribuição

Este é um projeto open-source. Contribuições são bem-vindas! Por favor, leia nosso [guia de contribuição](CONTRIBUTING.md) para saber como reportar bugs, sugerir funcionalidades e submeter pull requests.

## Licença

Este projeto é distribuído sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.