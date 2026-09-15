{...}: {
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            # 1. PDFs (Set to Okular. Swap to "onlyoffice-desktopeditors.desktop" if preferred)
            "application/pdf" = "org.kde.okular.desktop";

            # 2. Text Files (Set to Kate)
            "text/plain" = "org.kde.kate.desktop";

            # 3. Typical Office Types (Set to ONLYOFFICE)
            # Word Documents
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "onlyoffice-desktopeditors.desktop"; # .docx
            "application/msword" = "onlyoffice-desktopeditors.desktop"; # .doc
            "application/vnd.oasis.opendocument.text" = "onlyoffice-desktopeditors.desktop"; # .odt

            # Excel Spreadsheets
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "onlyoffice-desktopeditors.desktop"; # .xlsx
            "application/vnd.ms-excel" = "onlyoffice-desktopeditors.desktop"; # .xls
            "application/vnd.oasis.opendocument.spreadsheet" = "onlyoffice-desktopeditors.desktop"; # .ods

            # PowerPoint Presentations
            "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "onlyoffice-desktopeditors.desktop"; # .pptx
            "application/vnd.ms-powerpoint" = "onlyoffice-desktopeditors.desktop"; # .ppt
            "application/vnd.oasis.opendocument.presentation" = "onlyoffice-desktopeditors.desktop"; # .odp

            # Generic CSVs
            "text/csv" = "onlyoffice-desktopeditors.desktop"; # .csv
        };
    };
}
