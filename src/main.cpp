//Copyright (c) 2018 Ultimaker B.V.
//CuraEngine is released under the terms of the AGPLv3 or higher.

#include <iostream> //To change the formatting of std::cerr.
#if defined(__linux__) || (defined(__APPLE__) && defined(__MACH__))
    #include <sys/resource.h> //For setpriority.
#endif
#include "Application.h"
#include "utils/logoutput.h"

int main(int argc, char **argv)
{
#if defined(__linux__) || (defined(__APPLE__) && defined(__MACH__))
    //Lower the process priority on linux and mac. On windows this is done on process creation from the GUI.
    setpriority(PRIO_PROCESS, 0, 10);
#endif

    std::cerr << std::boolalpha;

    cura::Application::getInstance().run(argc, argv);

    return 0;
}
