# 💻 TUI Framework v0.0.1 (Pre-Alpha)

> Eksperymentalny, asynchroniczny i wielowątkowy framework TUI dla systemu Windows, napisany w nowoczesnym C++. Działa bezpośrednio na czystym WinAPI – bez ociężałych zewnętrznych zależności.

![GitHub repo size](https://img.shields.io/github/repo-size/Enter-a-new-username51/TUI)
![GitHub language count](https://img.shields.io/github/languages/count/Enter-a-new-username51/TUI)
![GitHub last commit](https://img.shields.io/github/last-commit/Enter-a-new-username51/TUI)

---

## 🧐 O co tutaj chodzi?

Projekt powstał z czystej programistycznej zajawki i chęci okiełznania konsoli Windowsa (`conhost.exe`) na poziomie struktury systemowej. Całość opiera się na niskopoziomowych mechanizmach Windows API, asynchronicznej pętli zdarzeń oraz bezpośrednim manipulowaniu buforem ekranu przy użyciu struktury `CHAR_INFO`. 

**Stan projektu:** Głęboka, wczesna wersja eksperymentalna (Alpha). Kod implementuje solidne mechanizmy synchronizacji i zarządzania pamięcią, stanowiąc świetny poligon doświadczalny dla systemowego C++.

---

## 🛠️ Architektura wielowątkowa

Framework opiera się na separacji zadań pomiędzy trzy niezależne, ściśle zsynchronizowane wątki:
1. **Wątek wejścia (`framework_input_thread`):** Blokująco nasłuchuje zdarzeń systemowych z klawiatury i myszy przy użyciu `ReadConsoleInputW`, przerzucając je do bufora globalnego.
2. **Wątek zdarzeń (`framework_event_thread`):** Konsumuje bufor wejściowy, przetwarza logikę i dystrybuuje paczki danych do zarejestrowanych słuchaczy (`EventListenerBuffer`), sterując stanem kontrolek.
3. **Wątek renderowania (`main_framework_thread`):** Działa w oparciu o technikę double-bufferingu. Synchronizuje stan ekranu przez `std::condition_variable` i wykonuje atomowy zrzut pamięci na ekran przez systemowe `WriteConsoleOutput`.

### Bezpieczeństwo wątkowe (Thread Safety)
Mimo dynamicznej zmiany rozmiaru okna w locie (`WINDOW_BUFFER_SIZE_EVENT`), framework gwarantuje brak błędów typu *Access Violation* podczas renderowania. Zmiana rozmiaru wektora pamięci oraz funkcja `WriteConsoleOutput` są **w pełni zsynchronizowane za pomocą mutexa (`screen_mutex`)**, co zapobiega unieważnieniu wskaźników sterty w trakcie operacji I/O.

---

## 🛠️ Specyfikacja Techniczna

* **Język:** Modern C++ (używamy m.in. `std::source_location` oraz zaawansowanej obsługi `std::function`).
* **Zależności:** Całkowicie czyste WinAPI (`<Windows.h>`) + STL. Zero zewnętrznych bibliotek zewnętrznych.
* **Zarządzanie zasobami:** Wykorzystanie mechanizmów RAII, sprytnych wskaźników (`std::unique_ptr`) oraz dedykowanego szablonu `ControlHandle<T>` do bezpiecznego dostępu do komponentów UI.

---

## 📊 Stan deweloperski komponentów

```mermaid
xychart-beta
    title "Zaawansowanie technologiczne modułów (Skala 0-100)"
    x-axis [Niskopoziomowe WinAPI, Renderowanie i Bufory, Architektura Watkow, Ekosystem Kontrolek]
    y-axis "Punkty zaawansowania" 0 --> 100
    bar [90, 85, 80, 40]
