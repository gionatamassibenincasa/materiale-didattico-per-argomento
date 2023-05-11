<!DOCTYPE html>
<html lang="it">
    <head>
        <title>Professore Web - <?=$titolo?></title>
        <meta charset="utf-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.classless.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            .tooltip {
                position: relative;
                -display: inline-block;
                margin-top: 100px;
            }

            .tooltip .tooltiptext {
                visibility: hidden;
                width: 120px;
                background-color: #555;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 5px 0;
                position: absolute;
                z-index: 1;
                bottom: 125%;
                left: 50%;
                margin-left: -60px;
                opacity: 0;
                transition: opacity 1s;
            }

            .tooltip .tooltiptext::after {
                content: "";
                position: absolute;
                top: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: #555 transparent transparent transparent;
            }

            .tooltip:hover .tooltiptext {
                visibility: visible;
                opacity: 1;
            }
        </style>
    </head>
    <body>
        <div>
            <nav class="container-fluid">
                <ul>
                <li>
                    <a href="./" class="contrast" onclick="event.preventDefault()"
                    ><strong>Professore Web</strong></a
                    >
                </li>
                </ul>
                <ul>
                <li>
                    <details role="list" dir="rtl">
                    <summary aria-haspopup="listbox" role="link" class="contrast">Tema</summary>
                    <ul role="listbox">
                        <li><a href="#" data-theme-switcher="auto">Auto</a></li>
                        <li><a href="#" data-theme-switcher="light">Light</a></li>
                        <li><a href="#" data-theme-switcher="dark">Dark</a></li>
                    </ul>
                    </details>
                </li>
                </ul>
            </nav>
            <header class="container">
                <hgroup>
                <h1><?=$intestazione?></h1>
                </hgroup>
            </header>
        </div>
        <main class="container">