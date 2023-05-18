<!DOCTYPE html>
<html lang="it">

<head>
    <title>Professore Web - <?= $titolo ?></title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@next/css/pico.min.css" />
    <link rel="stylesheet" href="css/custom.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
    <header class="container">
        <nav>
            <ul>
                <li>
                    <a href="./" class="contrast" onclick="event.preventDefault()"><strong>Professore Web</strong></a>
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
        <hgroup>
            <h1><?= $intestazione ?></h1>
        </hgroup>
    </header>
    <main class="container">