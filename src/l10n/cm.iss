// © _McClayn, 2023 demo \\

[CustomMessages]
en.languageIsNotFullySupports=Setup English translation is not full enough yet. Some of items descriptions may be not translated.%nWe working on it, sorry for the inconvenience ;)
ru.languageIsNotFullySupports=

en.warning=Warning!
ru.warning=Внимание!

en.runningApplicationFound=Running "%s" application found.%nIt is recommended that you allow Setup to automatically close these application.
// sgGameName(GamePatch,'') {#GameFullName}   FmtMessage(SetupMessage(msgNotOnThisPlatform), ['sgGameName(GamePatch,'')']);
ru.runningApplicationFound=Обнаружено запущенное приложение "%s".%nПеред продолжением требуется закрыть все экземпляры приложения.%nЗакрыть игру?
// sgGameName(GamePatch,'') {#GameFullName}    FmtMessage(SetupMessage(msgNotOnThisPlatform), ['sgGameName(GamePatch,'')']);

en.updCheckButtonText=Check...
ru.updCheckButtonText=Проверка...
en.updDownloadButtonText=Download
ru.updDownloadButtonText=Загрузка
en.updCancelButtonText=Cancel
ru.updCancelButtonText=Отмена
en.updStatusLabelText=Update status:
ru.updStatusLabelText=Состояние обновления:
en.updInfoLabelTextDefault=Check for updates is not performed.
ru.updInfoLabelTextDefault=Проверка не произведена.
en.updInfoLabelServerFailText=Server connection failed or there is no internet connection at all.%nClick «Next» to continue installation.
ru.updInfoLabelServerFailText=Подключение к серверу не удалось или отсутствует подключение к сети.%nВы можете продолжить установку в обычном режиме, нажав кнопку «Далее».
en.updInfoLabelVersionFailText=Unknown version.%nClick «Check» to retry. Or click «Next» to continue installation.
ru.updInfoLabelVersionFailText=Неизвестная версия. Чтобы проверить обновления снова, нажмите кнопку «Проверка».%nИли продолжайте установку в обычном режиме, нажав кнопку «Далее».
en.updTextLabelDefault=Changes list:
ru.updTextLabelDefault=Список изменений:
en.updRTFPrevChangesText=%n%nPrevious versions changes list:%n%n
ru.updRTFPrevChangesText=%n%nИзменения прошлых версий:%n%n
en.updInfoLabelTextVersionAvailable=There is update available. Your version: {#Version}, new version: %s.%nClick «Download» to automatically update your version.
ru.updInfoLabelTextVersionAvailable=Доступно обновление для инсталлятора. Текущая версия: {#Version}, новая версия: %s.%nДля загрузки новой версии нажмите кнопку «Загрузка».
en.updTextLabelVersionAvailable=Changes in new modpack version:
ru.updTextLabelVersionAvailable=Список изменений в новой версии сборки:
en.updInfoLabelTextVersionBeta=You are using modpack test-version.%nYour version: {#Version}, latest knowing version: %s.
ru.updInfoLabelTextVersionBeta=Вы используете тестовую версию сборки, так как она не указана на сервере.%nВаша версия: {#Version}, версия на сервере: %s.
en.updTextLabelVersionBeta=Details:
ru.updTextLabelVersionBeta=Подробнее:
en.updInfoLabelVersionActual=Version is up to date. You are using actual version ({#Version}).%nClick «Next» to continue.
ru.updInfoLabelVersionActual=Обновление не требуется. Вы используете последнюю версию сборки ({#Version}).%nНажмите кнопку «Далее» для продолжения установки.

en.applicationNotFound=Required "%s" application files not found in directory chosen.
// sgGameName(GamePatch,'') {#GameFullName}  FmtMessage(SetupMessage(msgNotOnThisPlatform), ['sgGameName(GamePatch,'')']);
ru.applicationNotFound=Необходимые файлы приложения "%s" не найдены.
// sgGameName(GamePatch,'') {#GameFullName}  FmtMessage(SetupMessage(msgNotOnThisPlatform), ['sgGameName(GamePatch,'')']);
en.applicationWrongDir=It is wrong game client root directory. Please, make sure that you choose right game client root directory and try again.
ru.applicationWrongDir=Выбрана неправильная директория для установки.%nПожалуйста, проверьте правильность пути к папке с игрой и попробуйте снова.
en.applicationIncompleteType=It is required to finish installing\updating game client, before continue this Setup.
ru.applicationIncompleteType=Необходимо завершить установку\обновление клиента, прежде чем продолжить установку.
en.applicationPatchUnapplyable=Inappropriate game client version: %s%nThis Setup requires version %s
//{#Patch}
ru.applicationPatchUnapplyable=Неподходящая версия установленного клиента: %s%nСборка предназначена для патча %s
//{#Patch}

en.googleAnalyticsApplying=I agree for this modpack to use Google Analytics service.
ru.googleAnalyticsApplying=Я согласен на использование этим модпаком сервиса Google Analytics.
en.googleAnalyticsDescription=It is recommended that you select the option to remove all installed mods to %navoid compatibility issues and conflicts of outdated versions. This will clear %nthe mods/{# Patch}, res_mods/{# Patch}, mods/configs and res_mods/configs folders.
ru.googleAnalyticsDescription=Рекомендуется выбрать вариант с удалением всех установленных модов во избижание%nпроблем совместимости и конфликтов устаревших версий. При этом будут очищены %nпапки mods/{#Patch}, res_mods/{#Patch}, mods/configs и res_mods/configs.

en.backupHeaderText=Choose how you want to install the soundpack.
ru.backupHeaderText=Выберите, как нужно произвести установку модпака.
en.deleteButtonText=Delete all installed modifications.
ru.deleteButtonText=Полная очистка игрового клиента от установленных модификаций.
en.backupButtonText=Create already installed modifications backup.
ru.backupButtonText=Создание резервной копии установленных в данный момент модификаций.
en.noneButtonText=Do not do anything. Save already installed modifications (not recommended).
ru.noneButtonText=Не предпринимать никаких действий по отношению к установленным модификациям.
en.cleanProfileButtonText=Clear game client profile (reset client settings and caches).
ru.cleanProfileButtonText=Очистка профиля игрового клиента (сброс индивидуальных настроек и кэша).
en.paramsRememberButtonText=Remember this Setup settings (recommended).
ru.paramsRememberButtonText=Запомнить выбранные параметры текущей установки (рекомендуется).

en.descriptionMemoDefaultText=Move cursor over some item in the list to see it description and preview.
ru.descriptionMemoDefaultText=Наведите курсор на компонент в списке, чтобы увидеть его описание и скриншот.
en.descriptionMemoItemUnavailable= Temporary unavailable.
ru.descriptionMemoItemUnavailable= Временно недоступно.

en.soundPreview=Sound preview
ru.soundPreview=Предпрослушивание звуков
en.soundPreviewVolumeWarning=In avoiding from unexpectedly loud sound playing, check your system volume level.%nAlso take notice that Setup has own volume level (in bottom window part).
ru.soundPreviewVolumeWarning=Во избежание неожиданно громкого звучания, обратите внимание на выставленную громкость в системе.%nТакже, обратите внимание на ползунок громкости в нижней части окна установщика.
en.soundPreviewVolume=Volume: %d%%
ru.soundPreviewVolume=Громкость: %d%%
                                     
en.readyLabelText=Click «Install» to start installation, or click «Back» if you want to review or change any settings.
ru.readyLabelText=Нажмите «Установить», чтобы продолжить, или «Назад», чтобы изменить опции установки.
en.readyMemoExtFunctions=Game client operations:
ru.readyMemoExtFunctions=Функции работы с клиентом:
en.readyMemoExtOptions=Additional Setup tasks:
ru.readyMemoExtOptions=Дополнительные опции установки:
en.readyMemoInstallDir=Install directory:
ru.readyMemoInstallDir=Директория установки:
en.readyMemoSelectedItems=Selected items:
ru.readyMemoSelectedItems=Выбранные компоненты:

en.xvmDownloading=XVM download
ru.xvmDownloading=Загрузка XVM
en.xvmCheckVersionFail=Something went wrong while getting XVM current version information.%nYou can install XVM by yourself. Or restart Setup and try again.
ru.xvmCheckVersionFail=Не удалось получить информацию об актуальных версиях мода XVM.%nВы можете установить мод вручную, загрузив его с официального сайта. Или попробовать перезапустить процесс установки.
en.xvmDownloadingFail=An unexpected error occured while downloading XVM.%nYou can install XVM by yourself. Or restart Setup and try again.
ru.xvmDownloadingFail=При загрузке XVM возникла непредвиденная ошибка.%nВы можете установить мод вручную, загрузив его с официального сайта. Или попробовать перезапустить процесс установки.

en.instStatusLabelTextDeleting=Deleting existing modifications...
ru.instStatusLabelTextDeleting=Удаление ранее установленных модификаций...
en.instStatusLabelTextBackupping=Creating installed modifications backup...
ru.instStatusLabelTextBackupping=Создание резервной копии ранее установленных модификаций...
en.instStatusLabelTextProfileClearing=Clearing game client profile...
ru.instStatusLabelTextProfileClearing=Очистка профайла игрового клиента...

en.instLabelText=Please wait while Setup installs...
ru.instLabelText=Пожалуйста, дождитесь завершения установки...
en.instProgressLabelText=Progress: %.1d%%
ru.instProgressLabelText=Выполнено: %.1d%%

en.instStatusBase=Unpacking base files...
ru.instStatusBase=Распаковка файлов...
en.instStatusXvm=Installing XVM-config...
ru.instStatusXvm=Установка XVM-конфига...
en.instStatusPmod=Installing PMOD...
ru.instStatusPmod=Установка PMOD...
en.instStatusTweaker=Installing Wot-Tweaker...
ru.instStatusTweaker=Установка Wot-Tweaker...

en.finishedPageTasksText=Extended Setup tasks:
ru.finishedPageTasksText=Дополнительные задачи установщика:

en.welcomePageTextMain=Welcome to the Installation Wizard, modpack from TankiMods
ru.welcomePageTextMain=Вас приветствует Мастер установки сборки от TankiMods

en.welcomePageTextPatchLesta={#PatchLesta} [Lesta]
// [Lesta] {#PatchLesta}
ru.welcomePageTextPatchLesta={#PatchLesta} [Lesta]
// [Lesta] {#PatchLesta}

en.welcomePageTextPatchWG={#PatchWG} [WG]
// [WG] {#PatchWG}
ru.welcomePageTextPatchWG={#PatchWG} [WG]
// [WG] {#PatchWG}

en.welcomePageTextGame={#GameVersionLesta}
//{#GameVersionLesta} / {#GameVersionWG}
ru.welcomePageTextGame={#GameVersionLesta}
//{#GameVersionLesta} / {#GameVersionWG}


en.browserYTButtonText=Visit JustSherlock YouTube Channel.
ru.browserYTButtonText=Посетить канал JustSherlock на YouTube.
//
en.launchGameButtonText=Launch game client (Tanki.exe) after Setup finished.
ru.launchGameButtonText=Запустить игру (Tanki.exe) после закрытия установщика.



en.checkInstalledMessage=You already have %1 installed (version %2). To continue with the installation, you must uninstall the previous version.%nClick "Yes" to exit the installer and activate the complete removal of the already installed version of the modpack.%n%nUninstaller: %3
ru.checkInstalledMessage=У Вас уже установлен %1 (версия %2). Для продолжения установки необходимо удалить предыдущую версию.%nНажмите "Да", чтобы выйти из программы установки и запустить автоматическое удаление уже установленной версии модпака.%n%nДеинсталлятор: %3



en.open_website=Open website justsherlock.ru
ru.open_website=Посетить сайт justsherlock.ru

en.openwg_unknown=Unknown
ru.openwg_unknown=Неизвестно
en.openwg_client_not_found=The game client was not detected in the specified folder.
ru.openwg_client_not_found=В указанной папке клиент игры не был обнаружен.
en.openwg_branch_release=Release
ru.openwg_branch_release=Релиз
en.openwg_branch_ct=Common Test
ru.openwg_branch_ct=Общий тест
en.openwg_branch_st=Super Test
ru.openwg_branch_st=Супертест
en.openwg_branch_sb=Sandbox
ru.openwg_branch_sb=Песочница

en.version_not_match_lesta=This client is not supported.%n%nThis installer only supports MT v{#PatchLesta}
ru.version_not_match_lesta=Выбранный клиент не поддерживается.%n%nЭтот установщик поддерживает только MT v{#PatchLesta}
en.version_not_match_wg=This client is not supported.%n%nThis installer only supports WoT v{#PatchWG}
ru.version_not_match_wg=Выбранный клиент не поддерживается.%n%nЭтот установщик поддерживает только WoT v{#PatchWG}
en.client_started=The selected client is running.%n%nDo you want to terminate the selected client?
ru.client_started=Выбранный клиент запущен.%n%nЖелаете ли вы закрыть данный клиент?