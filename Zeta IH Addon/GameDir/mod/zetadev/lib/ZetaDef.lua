--ZetaDef.lua
--Purpose: Where commonly used defines are kept, such as lang strings, file paths and various settings.
--ZIP: The commented out translations require an upcoming update of IHHook! For now, they're disabled.
local this={
	--Module Info
	modVersion=21,
	modName="Zeta",
	modIntroText="( IH Add-on )",
	--Common Filepaths
	modFolder="zeta",
	modDevFolder="zetadev",
	modSvarSave="zeta_svars.lua",
	modPrevSvarSave="zeta_svars_prev.lua",
	--Common Defs
	settingsName = "ZetaSetting",
	customSettingsName = "ZetaCustomSetting",
	loadOrderName = "ZetaOrder",
	modActiveName = "Zeta",
	modFaveName = "ZetaFave",
	--Common Strings
	settingOptionLabel = "Settings for ",
	errorLoadMsg = "Can not be loaded. Check the file for errors!",
	--Zeta Menu Lang
	zetaMenuModToggle = {
		name = {
			eng = "Active",
			--cht = "啟用",
			--fre = "Actif",
			ger = "Aktiv",
			ita = "Attivo",
			--jpn = "アクティブ",
			--kor = "활성",
			por = "Ativo",
			--rus = "Активный",
			spa = "Activo"
		},
		desc = function(modName) 
			local newDesc = {
				eng = "Enables or disables "..modName,
				--cht = "啟用或停用 "..modName,
				--fre = "Active ou désactive "..modName,
				ger = modName.." aktivieren oder deaktivieren",
				ita = "Abilita o disabilita "..modName,
				--jpn = modName.." の有効化または無効化",
				--kor = modName.."을(를) 활성화하거나 비활성화합니다",
				por = "Ativa ou desativa "..modName,
				--rus = "Включает или отключает "..modName,
				spa = "Activa o desactiva "..modName,
			}
			return newDesc
		end
	},
	zetaMenuModOrder = {
		name = {
			eng = "Load Order",
			--cht = "載入順序",
			--fre = "Ordre de chargement",
			ger = "Lade-Reihenfolge",
			ita = "Ordine di caricamento",
			--jpn = "ロード順序",
			--kor = "로드 순서",
			por = "Ordem de carregamento",
			--rus = "Порядок загрузки",
			spa = "Orden de carga"
		},
		desc = function(modName) 
			local newDesc = {
				eng = "Changes the load order of "..modName,
				--cht = "更改 "..modName.." 的載入順序",
				--fre = "Modifie l'ordre de chargement de "..modName,
				ger = "Ändert die Lade-Reihenfolge von "..modName,
				ita = "Modifica l'ordine di caricamento di "..modName,
				--jpn = modName.." のロード順序を変更する",
				--kor = modName.."의 로드 순서를 변경합니다",
				por = "Altera a ordem de carregamento de "..modName,
				--rus = "Изменяет порядок загрузки "..modName,
				spa = "Cambia el orden de carga de "..modName,
			}
			return newDesc
		end
	},
	zetaMenuModFave = {
		name = {
			eng = "Favorite",
			--cht = "最愛",
			--fre = "Favori",
			ger = "Favorit",
			ita = "Preferito",
			--jpn = "お気に入り",
			--kor = "즐겨찾기",
			por = "Favorito",
			--rus = "Избранное",
			spa = "Favorito"
		},
		desc = {
			eng = "Add selected mod to Favorites menu!",
			--cht = "將選定的模組新增至最愛選單！",
			--fre = "Ajouter le mod sélectionné au menu des favoris !",
			ger = "Ausgewählten Mod zum Favoriten-Menü hinzufügen!",
			ita = "Aggiungi la mod selezionata al menu dei preferiti!",
			--jpn = "選択したMODをお気に入りメニューに追加！",
			--kor = "선택한 모드를 즐겨찾기 메뉴에 추가하세요!",
			por = "Adicionar o mod selecionado ao menu de favoritos!",
			--rus = "Добавить выбранный мод в меню избранного!",
			spa = "¡Añade el mod seleccionado al menú de favoritos!"
		}
	},
	generalSettings = {
		name={
			eng = "General Settings",
			--cht = "一般設定",
			--fre = "Paramètres généraux",
			ger = "Allgemeine Einstellungen",
			ita = "Impostazioni generali",
			--jpn = "一般設定",
			--kor = "일반 설정",
			por = "Configurações gerais",
			--rus = "Общие настройки",
			spa = "Configuración general"
		},
		desc = {
			eng = "Change general settings for Zeta",
			--cht = "更改一般設定",
			--fre = "Modifier les paramètres généraux",
			ger = "Allgemeine Einstellungen ändern",
			ita = "Modifica le impostazioni generali",
			--jpn = "一般設定を変更する",
			--kor = "일반 설정 변경",
			por = "Alterar as configurações gerais",
			--rus = "Изменить общие настройки",
			spa = "Cambiar la configuración general"
		}
	},
	modManagement = {
		name = {
			eng = "Mod Management",
			--cht = "模組管理",
			--fre = "Gestion des mods",
			ger = "Mod-Verwaltung",
			ita = "Gestione mod",
			--jpn = "MOD管理",
			--kor = "모드 관리",
			por = "Gerenciamento de mods",
			--rus = "Управление модами",
			spa = "Gestión de mods"
		},
		desc = {
			eng = "Toggle, arrange and change the settings of mods",
			--cht = "切換、排列和更改模組的設定",
			--fre = "Activer, organiser et modifier les paramètres des mods",
			ger = "Mods umschalten, anordnen und Einstellungen ändern",
			ita = "Attiva, organizza e modifica le impostazioni delle mod",
			--jpn = "MODのトグル、並べ替え、および設定の変更",
			--kor = "모드를 전환하고 정렬하며 설정을 변경하세요",
			por = "Alternar, organizar e alterar as configurações dos mods",
			--rus = "Переключайте, располагайте и изменяйте настройки модов",
			spa = "Alternar, organizar y cambiar la configuración de los mods"
		}
	},
	reloadMods = {
		name = {
			eng = "Reload Mods",
			--cht = "重新載入模組",
			--fre = "Recharger les mods",
			ger = "Mods neu laden",
			ita = "Ricarica le mod",
			jpn = "MODをリロードする",
			--kor = "모드 다시 불러오기",
			por = "Recarregar os mods",
			--rus = "Перезагрузить моды",
			spa = "Recargar los mods"
		},
		desc = {
			eng = "Refreshes file list and reloads all mods",
			--cht = "重新整理檔案清單並重新載入所有模組",
			--fre = "Actualise la liste des fichiers et recharge tous les mods",
			ger = "Aktualisiert die Dateiliste und lädt alle Mods neu",
			ita = "Aggiorna l'elenco dei file e ricarica tutte le mod",
			--jpn = "ファイルリストを更新し、すべてのMODをリロードする",
			--kor = "파일 목록을 새로 고치고 모든 모드를 다시 불러옵니다",
			por = "Atualiza a lista de arquivos e recarrega todos os mods",
			--rus = "Обновляет список файлов и перезагружает все моды",
			spa = "Actualiza la lista de archivos y recarga todos los mods"
		}
	},
	favoriteMods = {
		name = {
			eng = "Favorite Mods",
			--cht = "最愛的模組",
			--fre = "Mods favoris",
			ger = "Favorisierte Mods",
			ita = "Mod preferite",
			--jpn = "お気に入りのMOD",
			--kor = "즐겨찾는 모드",
			por = "Mods favoritos",
			--rus = "Избранные моды",
			spa = "Mods favoritos"
		},
		desc = {
			eng = "Keeps all of your favorite mods in one menu",
			--cht = "將所有喜愛的模組保存在一個選單中",
			--fre = "Regroupe tous vos mods favoris dans un seul menu",
			ger = "Behält alle deine Lieblings-Mods in einem Menü",
			ita = "Mantiene tutte le tue mod preferite in un unico menu",
			--jpn = "お気に入りのMODをすべて1つのメニューにまとめます",
			--kor = "즐겨찾는 모드를 한 메뉴에 모두 보관합니다",
			por = "Mantém todos os seus mods favoritos em um único menu",
			--rus = "Собирает все ваши избранные моды в одном меню",
			spa = "Mantiene todos tus mods favoritos en un menú"
		}
	},
	showAllMods = {
		name = {
			eng = "Show all mods",
			--cht = "顯示所有模組",
			--fre = "Afficher tous les mods",
			ger = "Alle Mods anzeigen",
			ita = "Mostra tutte le mod",
			--jpn = "すべてのMODを表示",
			--kor = "모든 모드 보기",
			por = "Mostrar todos os mods",
			--rus = "Показать все моды",
			spa = "Mostrar todos los mods"
		},
		desc = {
			eng = "Displays all installed mods",
			--cht = "顯示所有已安裝的模組",
			--fre = "Affiche tous les mods installés",
			ger = "Zeigt alle installierten Mods an",
			ita = "Mostra tutte le mod installate",
			--jpn = "インストールされたすべてのMODを表示",
			--kor = "설치된 모든 모드를 표시합니다",
			por = "Exibe todos os mods instalados",
			--rus = "Показывает все установленные моды",
			spa = "Muestra todos los mods instalados"
		},
	},
	categories = {
		name = {
			eng = "Categories",
			--cht = "分類",
			--fre = "Catégories",
			ger = "Kategorien",
			ita = "Categorie",
			--jpn = "カテゴリー",
			--kor = "카테고리",
			por = "Categorias",
			--rus = "Категории",
			spa = "Categorías"
		},
		desc = {
			eng = "Displays all categories for all installed mods",
			--cht = "顯示所有已安裝模組的所有分類",
			--fre = "Affiche toutes les catégories pour tous les mods installés",
			ger = "Zeigt alle Kategorien für alle installierten Mods an",
			ita = "Mostra tutte le categorie per tutte le mod installate",
			--jpn = "インストールされたすべてのMODのすべてのカテゴリを表示",
			--kor = "설치된 모든 모드의 모든 카테고리를 표시합니다",
			por = "Exibe todas as categorias para todos os mods instalados",
			--rus = "Показывает все категории для всех установленных модов",
			spa = "Muestra todas las categorías de todos los mods instalados"
		}
	},
	authors = {
		name = {
			eng = "Authors",
			--cht = "作者",
			--fre = "Auteurs",
			ger = "Autoren",
			ita = "Autori",
			--jpn = "作者",
			--kor = "작성자",
			por = "Autores",
			--rus = "Авторы",
			spa = "Autores"
		},
		desc = {
			eng = "Displays all authors of all installed mods",
			--cht = "顯示所有已安裝模組的所有作者",
			--fre = "Affiche tous les auteurs de tous les mods installés",
			ger = "Zeigt alle Autoren aller installierten Mods an",
			ita = "Mostra tutti gli autori di tutte le mod installate",
			--jpn = "インストールされたすべてのMODのすべての作者を表示",
			--kor = "설치된 모든 모드의 모든 작성자를 표시합니다",
			por = "Exibe todos os autores de todos os mods instalados",
			--rus = "Показывает всех авторов всех установленных модов",
			spa = "Muestra todos los autores de todos los mods instalados"
		}
	},
	enabledDisabled = {
		name = {
			eng = "Enabled/Disabled",
			--cht = "啟用/停用",
			--fre = "Activé/Désactivé",
			ger = "Aktiviert/Deaktiviert",
			ita = "Abilitato/Disabilitato",
			--jpn = "有効/無効",
			--kor = "활성화/비활성화",
			por = "Ativado/Desativado",
			--rus = "Включено/Отключено",
			spa = "Activado/Desactivado"
		},
		desc = {
			eng = "Displays all enabled and disabled mods",
			--cht = "顯示所有已啟用和已停用模組",
			--fre = "Affiche tous les mods activés et désactivés",
			ger = "Zeigt alle aktivierten und deaktivierten Mods an",
			ita = "Mostra tutte le mod abilitate e disabilitate",
			--jpn = "有効および無効なすべてのMODを表示",
			--kor = "활성화된 모든 모드와 비활성화된 모든 모드를 표시합니다",
			por = "Exibe todos os mods ativados e desativados",
			--rus = "Показывает все включенные и отключенные моды",
			spa = "Muestra todos los mods activados y desactivados"
		}
	}
}
--Purpose: Defining nil enums for merging
TppEquip.UD_None = TppEquip.UB_None
TppEquip.LS_None = TppEquip.LT_None
return this