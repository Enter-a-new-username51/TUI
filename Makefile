# --- Narzędzia ---
CC     = cl.exe
LINKER = link.exe

# --- Flagi Kompilacji --- CFLAGS = /nologo /W4 /EHsc /Ox /Zi /MD /D_AMD64_ /DUNICODE /D_UNICODE /std:c++20
CFLAGS = /nologo /W4 /EHsc /Zi /D_AMD64_ /DUNICODE /D_UNICODE /std:c++20 /Zi /Od /RTC1 /MTd

# --- Flagi Linkera ---
LDFLAGS = /nologo /SUBSYSTEM:CONSOLE /DEBUG

# --- Biblioteki WinAPI ---
LIBS = kernel32.lib user32.lib advapi32.lib ntdll.lib shell32.lib

# --- Pliki projektu ---
TARGET = Test_For_TUI.exe
OBJS   = main.obj

# --- Reguły ---

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LINKER) $(LDFLAGS) /out:$(TARGET) $(OBJS) $(LIBS)
	@echo [OK] Zbudowano: $(TARGET) (x64 Native GUI)

.cpp.obj:
	$(CC) $(CFLAGS) /c $<

clean:
	del *.obj *.pdb *.ilk *.exe