unit principale;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Types3D, FMX.Ani, FMX.Objects3D, FMX.Controls3D,
  FMX.Viewport3D, FMX.MaterialSources, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Filter.Effects, system.IOUtils,
  System.Generics.Collections, FMX.Layers3D, Math;

type
  TTypeObjet = (batiment, arbre);

  type TWaveRec = record
    P, W : TPoint3D;
    S: TSphere;
    function Wave(aSum, aX, aY, aT : single):Single;
  end;

  TfPrincipale = class(TForm)
    viewport: TViewport3D;
    dmyMonde: TDummy;
    lSoleil: TLight;
    mSol: TMesh;
    textureSol: TLightMaterialSource;
    pMer: TPlane;
    textureMer: TLightMaterialSource;
    PLac: TPlane;
    dmySoleil: TDummy;
    faniJourNuit: TFloatAnimation;
    sSoleil: TSphere;
    CouleurSoleil: TColorMaterialSource;
    dmyJoueur: TDummy;
    Camera1: TCamera;
    lJoueur: TLight;
    layIHM: TLayout;
    Layout2: TLayout;
    tbVitesse: TTrackBar;
    Layout3: TLayout;
    TextureCielNuit: TTextureMaterialSource;
    sCiel: TSphere;
    faniPrincipale: TFloatAnimation;
    dmyJoueurOrientation: TDummy;
    modeleBatiment: TRectangle3D;
    modeleArbre: TModel3D;
    mModelArbeMat11: TLightMaterialSource;
    mModelArbeMat01: TLightMaterialSource;
    RoundRect1: TRoundRect;
    StyleBook1: TStyleBook;
    layOptions: TLayout;
    layLumiere: TLayout;
    viewportCarte: TViewport3D;
    dmyPositionJoueurCarte: TDummy;
    Camera2: TCamera;
    sPositionJoueur: TCone;
    lblHeure: TLabel;
    Rectangle1: TRectangle;
    lblTitre: TLabel;
    CaptureImageBTN: TImage;
    FillRGBEffect3: TFillRGBEffect;
    Label2: TLabel;
    Image1: TImage;
    FillRGBEffect1: TFillRGBEffect;
    cPhare: TCylinder;
    TexturePhare: TLightMaterialSource;
    sPhare: TSphere;
    mCouleurToitPhare: TColorMaterialSource;
    cEolienne: TCylinder;
    dmyEolienne: TDummy;
    Cone2: TCone;
    Plane1: TPlane;
    Plane2: TPlane;
    Plane3: TPlane;
    textureEolienne: TLightMaterialSource;
    cCouloirNoire: TColorMaterialSource;
    cbGrille: TCheckBox;
    imgLumiere: TImage;
    FillRGBEffect2: TFillRGBEffect;
    tbZoomCarte: TTrackBar;
    dmyNuages: TDummy;
    CouleurCielJour: TColorMaterialSource;
    TextureNuage: TLightMaterialSource;
    TextureNuage2: TLightMaterialSource;
    TextureNuage3: TLightMaterialSource;
    Layout1: TLayout;
    Image2: TImage;
    FillRGBEffect4: TFillRGBEffect;
    tbNuages: TTrackBar;
    Camera3: TCamera;
    imgCarte: TImage3D;
    modelBateau: TModel3D;
    dmyBateau: TDummy;
    lBateau: TLight;
    textureRemou: TLightMaterialSource;
    pRemou: TPlane;
    modelBateauMat01: TLightMaterialSource;
    modelBateauMat11: TLightMaterialSource;
    modelBateauMat21: TLightMaterialSource;
    modelBateauMat31: TLightMaterialSource;
    modelBateauMat41: TLightMaterialSource;
    modelBateauMat51: TLightMaterialSource;
    modelBateauMat61: TLightMaterialSource;
    Camera4: TCamera;
    CameraBateau: TImage;
    FillRGBEffect5: TFillRGBEffect;
    Layout5: TLayout;
    l1Ville1: TLight;
    l1Ville2: TLight;
    l1Ville3: TLight;
    l2Ville1: TLight;
    faniCiel: TFloatAnimation;
    textureBatiment: TLightMaterialSource;
    textureCoteBatiment: TLightMaterialSource;
    lblCollision: TLabel;
    dmyProchainePosition: TDummy;
    sOrigineVague: TSphere;
    pMerFond: TPlane;
    textureFondMer: TLightMaterialSource;
    procedure FormCreate(Sender: TObject);
    procedure viewportMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure viewportMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure faniJourNuitProcess(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure faniPrincipaleProcess(Sender: TObject);
    procedure viewportMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure CaptureImageBTNClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mSolRender(Sender: TObject; Context: TContext3D);
    procedure imgLumiereClick(Sender: TObject);
    procedure tbZoomCarteTracking(Sender: TObject);
    procedure dmyNuagesRender(Sender: TObject; Context: TContext3D);
    procedure modelBateauRender(Sender: TObject; Context: TContext3D);
    procedure Cone2Render(Sender: TObject; Context: TContext3D);
    procedure CameraBateauClick(Sender: TObject);
    procedure pMerRender(Sender: TObject; Context: TContext3D);
  private
    { Déclarations privées }
    FPosDepartCurseur: TPointF;    // Position du pointeur de souris au début du mouvement de la souris
    procedure SetAngleDeVue(const Value: TPointF); // Modification de l'angle de vue
    function GetDirection: TPoint3D;  // Direction du mouvement
    procedure ConstructionObjets(position, taille : TPoint3d; typeObjet : TTypeObjet; orientation : single = 0);
    procedure interactionIHM;
    procedure CreerPlan;
    procedure ChargerTextures;
    procedure genererObjets;
    procedure genererNuages;
    function CalculerHauteur(P: TPoint3D): single;
    function Barycentre(p1, p2, p3: TPoint3D; p4: TPointF): single;
    function DetectionCollisionObstacle: boolean;
    function SizeOf3D(const unObjet3D: TControl3D): TPoint3D;
    procedure CalcMesh;
    property posDepartCurseur: TPointF read FPosDepartCurseur write FPosDepartCurseur; // Propriété de la position du pointeur de souris au début du mouvement de la souris
    property angleDeVue : TPointF write SetAngleDeVue; // Propriété de l'angle de vue
    property direction : TPoint3D read GetDirection; // Propriété de la direction
  public
    { Déclarations publiques }
    debut : boolean;
    maHeightMap: TBitmap;    // Texture qui servira à générer le sol (le Mesh)
    indicePhoto : integer;   // Indice pour la sauvegarde des photos prises
    hauteurs : array of array of single; // Tableau à deux dimensions pour stocker les hauteur des sommets du TMesh
    entreEnCollisionObstacle : boolean; // Permet de savoir si le joueur est entré en collision avec un obstacle (batiment ou arbre)
    hauteurMin, demiHauteurJoueur, miseAEchelle, demiHauteurSol, temps : single;
    moitieCarte : integer;
    Center : TPoint3D;
    procedure CreerIle(const nbSubdivisions: integer); // Procédure qui crée le niveau
  end;

  TMEshHelper = class(TCustomMesh); // Va servir pour caster un TPlane en TMesh

const
  MaxSolMesh = 500;  /// Nombre de maille sur un côté du TMesh
  MaxMerMesh = 50;   // Nombre de maille sur un coté de pMer
  SizeMap = 500;     // Taille du côté du TMesh
  sizeHauteur = 50;  // Taille hauteur du TMesh
  TailleJoueur = 0.6;// Taille du joueur

var
  fPrincipale: TfPrincipale;

implementation

{$R *.fmx}
uses System.UIConsts, System.RTLConsts, FMX.Utils;

procedure TfPrincipale.faniJourNuitProcess(Sender: TObject);   // Animation qui simule le cycle jour/nuit
var
  minute: integer;   // sert pour afficher l'heure dans le jeu
begin
  // Initilisation de la scène à 12h : dmySoleil.RotationAngle.Z sera à 0
  if (dmySoleil.RotationAngle.Z >= 0) and (dmySoleil.RotationAngle.Z < 180) then  // lorsque l'angle Z est compris dans cette plage, on ajoute 720 à minutes
    minute := Round(dmySoleil.RotationAngle.Z*4) + 720  // fAniJourNuit est paramétrée pour qu'une journée dure 4 minutes (240 secondes cf fAniJourNuit.Duration)
  else  // sinon, on soustrait les 720 minutes
    minute := Round(dmySoleil.RotationAngle.Z*4)-720;

  lblHeure.text := Format('%.2d:%.2d', [minute div 60, minute mod 60]); // Affichage de l'heure dans le jeu en fonction de la rotation du Soleil

  // Aube ou crépuscule
  if ((dmySoleil.RotationAngle.Z > 80) and (dmySoleil.RotationAngle.Z < 100)) or
     ((dmySoleil.RotationAngle.Z > 260) and (dmySoleil.RotationAngle.Z < 280)) then
  begin
    viewport.Color := TAlphaColors.Darkblue;   // Couleur du fond en bleu foncé
    sCiel.MaterialSource := textureCielNuit;
    sCiel.Opacity := 0.5;
    lSoleil.Enabled := true;  // activaton de la lumière du Soleil
    lBateau.enabled := true;
    l1Ville1.Enabled := false;
    l2Ville1.Enabled := false;
    l1Ville2.Enabled := false;
    l1Ville3.Enabled := false;
  end
  else
  begin
    // Nuit
    if (dmySoleil.RotationAngle.Z >= 100) and (dmySoleil.RotationAngle.Z <= 260) then
    begin
      viewport.Color := TAlphaColors.Black;
      sCiel.Opacity := 1;
      lSoleil.Enabled := false;
      lBateau.enabled := false;
      l1Ville1.Enabled := true;
      l2Ville1.Enabled := true;
      l1Ville2.Enabled := true;
      l1Ville3.Enabled := true;
    end
    else
    begin
      viewport.Color := TAlphaColors.Cornflowerblue;
      sCiel.Opacity := 1;
      sCiel.MaterialSource := CouleurCielJour;
    end;
  end;
end;

procedure TfPrincipale.faniPrincipaleProcess(Sender: TObject);   // Boucle principale du jeu
begin
  if debut then
  begin
    CreerPlan; // Création de la carte
    debut := false;
  end
  else
  begin
    dmyProchainePosition.Position.Point := dmyJoueurOrientation.Position.Point + direction * tbVitesse.value;
    if length(hauteurs) > 0 then
    begin
      dmyProchainePosition.Position.Y := CalculerHauteur(dmyProchainePosition.Position.Point) - demiHauteurJoueur - TailleJoueur; // La hauteur de la position du joueur est lue dans le tableau des hauteurs en fonction des coorodonées X et Z
      if not(DetectionCollisionObstacle) then dmyJoueurOrientation.Position.Point := dmyProchainePosition.Position.Point;
    end;

    dmyProchainePosition.Position.Y := - 50;  // On place le dummy indiquant la position du joueur sur la carte au desssus
    dmyPositionJoueurCarte.Position.Point := dmyProchainePosition.Position.Point; // Mise à jour du TCone représentant la position du curseur sur la carte
  end;
end;

procedure TfPrincipale.FormCreate(Sender: TObject);
begin
  debut := true;
  randomize;
  temps := 0;
  Center := Point3D(MaxMerMesh / pMer.Width, MaxMerMesh / pMer.Height, 0);
  pMer.SubdivisionsHeight := MaxMerMesh;
  pMer.SubdivisionsWidth := MaxMerMesh;
  indicePhoto := 1;
  sCiel.visible := false;
  ChargerTextures; // Charge les différentes textures
  CreerIle(MaxSolMesh);  // Création du niveau (heightmap, immubles, arbres et autres objets
  moitieCarte := math.Floor(SizeMap/2);
  demiHauteurJoueur := dmyJoueurOrientation.Height/2;
  miseAEchelle := sizeHauteur / (-hauteurMin);
  demiHauteurSol := mSol.Depth/2;
end;

procedure TfPrincipale.FormDestroy(Sender: TObject);
begin
  FreeAndNil(maHeightMap);
end;

procedure TfPrincipale.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if key = vkup then tbVitesse.Value := tbVitesse.Value - tbVitesse.Frequency;  // la flèche Haut permet d'avancer
  if key = vkdown then tbVitesse.Value := tbVitesse.Value + tbVitesse.Frequency;// la flèche Bas permet de reculer
  if key = vkEscape then tbVitesse.Value := 0; // Echap permet de s'arrêter
  if key = vkLeft then dmyJoueurOrientation.RotationAngle.y:= dmyJoueurOrientation.RotationAngle.y - 1;  // orientation droite/gauche (axe y) en fonction du déplacement de la souris en X
  if key = vkRight then  dmyJoueurOrientation.RotationAngle.y:= dmyJoueurOrientation.RotationAngle.y + 1; // orientation droite/gauche (axe y) en fonction du déplacement de la souris en X
  sPositionJoueur.RotationAngle.Z := dmyJoueurOrientation.RotationAngle.y; // orientation du cône représentant la position du joueur sur la carte
  interactionIHM;
end;

procedure TfPrincipale.CreerIle(const nbSubdivisions: integer); // Création du niveau
var
  Basic : TPlane;             // TPlane qui va servir de base
  SubMap : TBitMap;           // Bitmap qui va servir pour générer le relief à partir du heightmap
  Front, Back : PPoint3D;
  M: TMeshData;               // informations du Mesh
  G, S, W, X, Y: Integer;
  zMap : Single;
  C : TAlphaColorRec;         // Couleur lue dans la heightmap et qui sert à déterminer la hauteur d'un sommet
  bitmapData: TBitmapData;    // nécessaire pour pouvoir accéder aux pixels d'un TBitmap
begin
  if nbSubdivisions < 1 then exit;  // il faut au moins une subdivision

  G:=nbSubdivisions + 1;
  S:= G * G;  // Nombre total de maille
  setlength(hauteurs, G, G);
  hauteurMin := 0;

  try
    Basic := TPlane.Create(nil);    // Création du TPlane qui va servir de base à la constitution du mesh
    Basic.SubdivisionsHeight := nbSubdivisions; // le TPlane sera carré et subdivisé pour le maillage (mesh)
    Basic.SubdivisionsWidth := nbSubdivisions;

    M:=TMeshData.create;       // Création du TMesh
    M.Assign(TMEshHelper(Basic).Data); // les données sont transférées du TPlane au TMesh

    SubMap:=TBitmap.Create(maHeightMap.Width,maHeightMap.Height);  // Création du bitmap
    SubMap.Assign(maHeightMap);    // On charge la heightmap

    blur(SubMap.canvas, SubMap, 8); // On floute l'image afin d'avoir des montagnes moins anguleuses

    if (SubMap.Map(TMapAccess.Read, bitmapData)) then  // nécessaire pour accéder au pixel du Bitmap afin d'en récupérer la couleur
    begin
      try
        for W := 0 to S-1 do  // Parcours de tous les sommets du maillage
        begin
          Front := M.VertexBuffer.VerticesPtr[W];    // Récupération des coordonnées du sommet (TPlane subdivisé pour rappel : on a les coordonnées en X et Y et Z est encore à 0 pour l'instant)
          Back := M.VertexBuffer.VerticesPtr[W+S];   // Pareil pour la face arrière
          X := W mod G; // absisse du maillage en cours de traitement
          Y:=W div G; // ordonnée du maillage en cours de traitement

          C:=TAlphaColorRec(CorrectColor(bitmapData.GetPixel(x,y))); // On récupère la couleur du pixel correspondant dans la heightmap
          zMap := (C.R  + C.G  + C.B ) / $FF * sizemap / 25; // détermination de la hauteur du sommet en fonction de la couleur

          hauteurs[X,Y] := -zMap; // On stocke la hauteur calculée
          if -zMap < hauteurMin then hauteurMin := -zmap;

          Front^.Z := zMap; // on affecte la hauteur calculée à la face avant
          Back^.Z := zMap;  // pareil pour la face arrière
        end;

        M.CalcTangentBinormals; // Calcul de vecteurs binormaux et de tangente pour toutes les faces (permet par exemple de mieux réagir à la lumière)
        mSol.SetSize(sizemap, sizemap, 50);  // Préparation du TMesh
        mSol.Data.Assign(M);  // On affecte les données du meshdata précédemment calculées au composant TMesh
      finally
        SubMap.Unmap(bitmapData);  // On libère le bitmap
      end;
    end;

    genererObjets; // Génération des objets (batiments, arbres, autres...)

  finally
    FreeAndNil(SubMap);
    FreeAndNil(M);
    FreeAndNil(Basic);
  end;

end;

function TfPrincipale.CalculerHauteur(P: TPoint3D) : single;
var
   grilleX, grilleZ : integer;  // indices à utiliser pour accéder au tableau hauteurs
   xCoord, zCoord, hauteurCalculee : single; // coordonnées X et Z dans le "carré"
begin
  // Détermination des indices permettant d'accéder à hauteurs en fonction de la position du joueur
  grilleX := Math.Floor(P.X+moitieCarte);
  grilleZ := Math.Floor(P.Z+moitieCarte);

  // Si on est en dehors du mSol, on force (arbitrairement) la hauteur à la hauteur de la mer
  if (grilleX >= MaxSolMesh) or (grilleZ >= MaxSolMesh) or (grilleX < 0) or (grilleZ < 0) then
  begin
    result := -pMer.Position.Z - demiHauteurJoueur;
  end
  else
  begin
    xCoord := Frac(P.X); // position X dans la maille courante
    zCoord := Frac(P.Z); // position y dans la maille courante

    // On détermine dans quel triangle on est
    if xCoord <= (1 - zCoord) then
    begin
      // On calcule la hauteur en fonction des 3 sommets du triangle dans lequel se trouve le joueur
      hauteurCalculee := Barycentre(TPoint3D.Create(0,hauteurs[grilleX,grilleZ],0),
                                    TPoint3D.Create(1,hauteurs[grilleX+1,grilleZ],0),
                                    TPoint3D.Create(0,hauteurs[grilleX,grilleZ+1],1),
                                    TPointF.Create(xCoord, zCoord));
    end
    else
    begin
      // On calcule la hauteur en fonction des 3 sommets du triangle dans lequel se trouve le joueur
      hauteurCalculee := Barycentre(TPoint3D.Create(1,hauteurs[grilleX+1,grilleZ],0),
                                    TPoint3D.Create(1,hauteurs[grilleX+1,grilleZ+1],1),
                                    TPoint3D.Create(0,hauteurs[grilleX,grilleZ+1],1),
                                    TPointF.Create(xCoord, zCoord));
    end;

    hauteurCalculee := hauteurCalculee * miseAEchelle + demiHauteurSol - demiHauteurJoueur;  // Hauteur calculée et mise à l'échelle (size 50 dans CreerIle et prise en compte des demis hauteurs)
    // Si la hauteur calculée est > à la hauteur de pMer, alors on retourne la hauteur de pMer
    if hauteurCalculee > -pMer.Position.Z then result := -pMer.Position.z
    else result := hauteurCalculee;
  end;
end;

// https://en.wikipedia.org/wiki/Barycentric_coordinate_system#Conversion_between_barycentric_and_Cartesian_coordinates
function TfPrincipale.Barycentre(p1, p2, p3 : TPoint3D; p4 : TPointF):single;
var
  det, l1, l2, l3 : single;
begin
  det := (p2.z - p3.z) * (p1.x - p3.x) + (p3.x - p2.x) * (p1.z - p3.z);
  l1  := ( (p2.z - p3.z) * (p4.x - p3.x) + (p3.x - p2.x) * (p4.y - p3.z) ) / det;
  l2  := ( (p3.z - p1.z) * (p4.x - p3.x) + (p1.x - p3.x) * (p4.y - p3.z) ) / det;
  l3  := 1 - l1 - l2;
  result := l1 * p1.y + l2 * p2.y + l3 * p3.y;
end;

procedure TfPrincipale.Cone2Render(Sender: TObject; Context: TContext3D);
begin
  cone2.RotationAngle.Y := cone2.RotationAngle.Y + 1;
end;

procedure TfPrincipale.ConstructionObjets(position, taille : TPoint3d; typeObjet : TTypeObjet; orientation : single = 0); // Création d'un batiment
var
  i: TProxyObject;  // Utilisation des TProxyObject
begin
  I := TProxyObject.Create(nil);   // Création
  mSol.AddObject(I);               // On lui affecte le TMesh comme parent
  case typeObjet of
    batiment: I.SourceObject:=modeleBatiment;  // On indique l'objet qui sert de modèle au TProxyObject;
    arbre: I.SourceObject:=modeleArbre;  // On indique l'objet qui sert de modèle au TProxyObject;
  end;
  I.Locked:=true;                  // Pour ne plus modifier l'objet en mode conception
  I.HitTest:=false;                // Ainsi, l'objet n'est pas sélectionnable via la souris
  i.name := 'Objet'+mSol.ChildrenCount.ToString;
  I.SetSize(taille.x,taille.y,taille.z); // On taille l'objet aux dimensions passées en paramètre
  I.Position.Point:=Position;            // De même pour la position
  i.RotationAngle.X := 90;
  i.RotationAngle.y := orientation;
  i.Visible := true;                     // On rend l'objet visible
end;

procedure TfPrincipale.CaptureImageBTNClick(Sender: TObject); // Permet de faire une copie d'écran
var
  b : TBitmap;
begin
  b := TBitmap.Create(width, height);                        // Création du TBitmap
  viewport.Context.CopyToBitmap(b,Rect(0,0,width, Height));  // Permet de copier dans le TBitmap ce qui est affiché dans le viewport

  if not(DirectoryExists('.'+PathDelim+'captures')) then ForceDirectories('.'+PathDelim+'captures'); // Création du sous répertoire "captures" où sera enregistré l'image

  b.SaveToFile('.'+PathDelim+'captures'+PathDelim+'capture'+indicePhoto.ToString+'.png');
  inc(indicePhoto);
  b.free;
end;

procedure TfPrincipale.SetAngleDeVue(const Value: TPointF);  // Evolution de l'angle de vue
var
  ptA,ptD,S : TPointF; // ptA point d'arrivé, ptD point de départ, S la sensibilité
begin
  S.X := 180 / Viewport.Width;    // Réglage de la sensibilité pour l'orientation droite/gauche
  S.Y := 180 / Viewport.Height;   // Réglage de la sensibilité pour l'orientation haut/bas
  ptA := Value * S;               // Point d'arrivée adapté à la sensibilité
  ptD := posDepartCurseur * S;          // Point de départ adapté à la sensibilité
  // Vue droite/gauche
  with dmyJoueurOrientation.RotationAngle do
  begin
    y:= y + (ptA.X - ptD.X);      // orientation droite/gauche (axe y) en fonction du déplacement de la souris en X
    sPositionJoueur.RotationAngle.Z := y; // orientation du cône représentant la position du joueur sur la carte
  end;
  // Vue Haut/Bas
  with dmyJoueur.RotationAngle do x:= x + (ptD.Y - ptA.Y);   // de même pour l'orientation haut/bas en adaptant (rotation sur l'axe x, e fonction du d'déplacement de la souris en Y
  posDepartCurseur := Value;   // la position du curseur lorsque l'utilisateur a cliqué (l'origine de la direction), est mis à jour avec la nouvelle position du curseur : au prochain appel de OnMouseMove, la position de départ doit être la position d'arrivée du coup précédent
end;

procedure TfPrincipale.tbZoomCarteTracking(Sender: TObject);
begin
  Camera2.Position.Y := - tbZoomCarte.Value;
  sPositionJoueur.Position.Y := Camera2.Position.Y + 10;
  interactionIHM;
end;

procedure TfPrincipale.viewportMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if ssLeft in shift then posDepartCurseur := PointF(X,Y);
end;

procedure TfPrincipale.viewportMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if ssLeft in shift then angleDeVue := PointF(X,Y);
  interactionIHM;
end;

procedure TfPrincipale.viewportMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
begin
  tbVitesse.Value := tbVitesse.Value - (WheelDelta/400);
end;

function TfPrincipale.GetDirection: TPoint3D;
begin
  result := Point3D(1,0,1) * (Camera1.AbsolutePosition - dmyJoueurOrientation.AbsolutePosition).Normalize;  // Détermination de l'orientation
end;

procedure TfPrincipale.CameraBateauClick(Sender: TObject);
begin
  if viewport.Camera = Camera1 then
  begin
    viewport.Camera := camera4;
    FillRGBEffect5.color := $FFD01414;
  end
  else
  begin
    viewport.Camera := camera1;
    FillRGBEffect5.color := $FFAE8220;
  end;
end;

procedure TfPrincipale.imgLumiereClick(Sender: TObject);
begin
  if FillRGBEffect2.Color = $FFAE8220 then
  begin
    lJoueur.Enabled := true;
    FillRGBEffect2.color := $FFD01414;
  end
  else
  begin
    lJoueur.Enabled := false;
    FillRGBEffect2.color := $FFAE8220;
  end;
end;

procedure TfPrincipale.interactionIHM;
begin
  faniPrincipale.ProcessTick(0,0);      // Permet de ne pas bloquer les animations pendant que l'utilisateur interagit avec l'interface graphique
  faniJourNuit.ProcessTick(0,0);
  faniCiel.ProcessTick(0,0);
end;

procedure TfPrincipale.modelBateauRender(Sender: TObject; Context: TContext3D);
begin
  dmyBateau.RotationAngle.Z := dmyBateau.RotationAngle.Z - 0.05;
end;

procedure TfPrincipale.mSolRender(Sender: TObject; Context: TContext3D);
begin
  // Permet d'afficher le maillage du TMesh si la case est cochée (utilisation de la couleur du toit du phare (bleu))
  if cbGrille.IsChecked then Context.DrawLines(mSol.Data.VertexBuffer, mSol.Data.IndexBuffer, TMaterialSource.ValidMaterial(mCouleurToitPhare),0.25);
end;

procedure TfPrincipale.pMerRender(Sender: TObject; Context: TContext3D);
begin
  CalcMesh;
  if cbGrille.IsChecked then Context.DrawLines(TMeshHelper(pMer).Data.VertexBuffer, TMeshHelper(pMer).Data.IndexBuffer, TMaterialSource.ValidMaterial(mCouleurToitPhare),0.25);
end;

procedure TfPrincipale.CreerPlan; // Permet de créer le plan (la carte)
var
  b : TBitmap;
begin
  sCiel.Visible := false;
  dmyNuages.Visible := false;
  sSoleil.Visible := false;
  dmySoleil.Visible := false;

  viewport.Camera := camera3;
  b := TBitmap.Create(round(viewport.width), round(viewport.height));
  viewport.Context.CopyToBitmap(b,Rect(0,0,round(viewport.Width), round(viewport.Height)));

  viewport.Camera := camera1;
  dmyNuages.Visible := true;
  sSoleil.Visible := true;
  dmySoleil.visible := true;
  dmyMonde.position.Y := 0;
  sCiel.Visible := true;

  imgCarte.Bitmap.Assign(b);
  b.Free;
end;

procedure TfPrincipale.dmyNuagesRender(Sender: TObject;
  Context: TContext3D);
begin
  genererNuages;
end;

procedure TfPrincipale.ChargerTextures; // Chargement des textures
begin
  textureSol.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'plan.png');
  textureMer.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'mer.jpg');
  textureFondMer.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'oceans.jpg');
  TextureCielNuit.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'cielnuit.png');
  textureBatiment.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'batiment.jpg');
  textureCoteBatiment.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'coteBatiment.png');
  texturePhare.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'phare.png');
  textureNuage.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'cloud1.png');
  textureNuage2.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'cloud2.png');
  textureNuage3.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'cloud3.png');
  textureRemou.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'remou2.png');
  maHeightMap:=TBitmap.Create;
  maHeightMap.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'heightmap.jpg');
end;

procedure TfPrincipale.genererObjets;  // Création des objets
begin
  // Ville 1
  ConstructionObjets(TPoint3D.Create(180,120,-15),TPoint3D.Create(4,8,2), batiment);
  ConstructionObjets(TPoint3D.Create(170,110,-15),TPoint3D.Create(4,12,2), batiment,60);
  ConstructionObjets(TPoint3D.Create(210,150,-17),TPoint3D.Create(20,6,3), batiment,90);
  ConstructionObjets(TPoint3D.Create(215,130,-15),TPoint3D.Create(4,8,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(220,120,-11),TPoint3D.Create(5,20,3), batiment,90);
  ConstructionObjets(TPoint3D.Create(225,140,-17),TPoint3D.Create(20,6,3), batiment,90);
  ConstructionObjets(TPoint3D.Create(200,110,-11),TPoint3D.Create(5,20,3), batiment);
  ConstructionObjets(TPoint3D.Create(200,120,-17),TPoint3D.Create(4,8,2), batiment);
  ConstructionObjets(TPoint3D.Create(190,140,-17),TPoint3D.Create(20,6,3), batiment,45);
  ConstructionObjets(TPoint3D.Create(170,150,-10),TPoint3D.Create(5,20,3), batiment,135);
  ConstructionObjets(TPoint3D.Create(190,130,-15),TPoint3D.Create(4,8,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(170,140,-8),TPoint3D.Create(5,20,3), batiment,90);
  ConstructionObjets(TPoint3D.Create(170,175,-11),TPoint3D.Create(5,20,3), batiment);
  ConstructionObjets(TPoint3D.Create(170,160,-15),TPoint3D.Create(4,8,2), batiment,90);
  // Ville 2
  ConstructionObjets(TPoint3D.Create(-165,200,-15),TPoint3D.Create(4,20,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-155,205,-15),TPoint3D.Create(4,8,2), batiment);
  ConstructionObjets(TPoint3D.Create(-150,190,-12),TPoint3D.Create(20,6,3), batiment,45);
  // Ville 3
  ConstructionObjets(TPoint3D.Create(-165,-62,-14),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-160,-62,-14),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-155,-62,-14),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-150,-62,-13),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-145,-62,-12),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-155,-40,-16),TPoint3D.Create(20,6,3), batiment);
  ConstructionObjets(TPoint3D.Create(-160,-50,-15),TPoint3D.Create(4,20,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-155,-55,-15),TPoint3D.Create(4,20,2), batiment);
  ConstructionObjets(TPoint3D.Create(-135,-45,-15),TPoint3D.Create(4,20,2), batiment);
  ConstructionObjets(TPoint3D.Create(-145,-50,-15),TPoint3D.Create(4,20,2), batiment);

  // Chargement de quelques arbres un peu partout sur le plateau
  ConstructionObjets(TPoint3D.Create(-19,18,15.2),TPoint3D.Create(10,10,10), arbre);
  ConstructionObjets(TPoint3D.Create(-19,22,15.1),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-18,25,14.3),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-16,23,14.2),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-20,28,14.6),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-24,29,15.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-26,27,15.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-25,24.5,16.2),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-26,20,16.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-10,0,14.7),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-12,7,17.9),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-13,-5,13.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-17,4,17.4),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(-17,9,18.3),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(0,-50,13),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(1,-48,13),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(3,-51,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(5,-46,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(20,-50,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(21,-48,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(23,-51,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(25,-46,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(26,-51,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(15,-50,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(16,-48,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(18,-51,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(20,-46,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(21,-51,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(30,-70,12.8),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(31,-80,11.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(35,-85,11.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(22,-80,11.6),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(24,-78,11.6),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(19,-82,11.6),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(20,-83,11.6),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(17,-81,11.6),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(14,-70,12),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(18,-68,12),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(15,-72,12),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(13,-73,12),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(14,-71,12),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(14,-60,12.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(18,-62,12.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(16,-58,12.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(12,-58,12.5),TPoint3D.Create(10,12,10), arbre);
  ConstructionObjets(TPoint3D.Create(13,-50,12.5),TPoint3D.Create(10,12,10), arbre);
end;

procedure TfPrincipale.genererNuages;
var
  s:TPlane;      // Pour création des TPlane
  P:TFmxObject;  // Va servir d'itérateur pour parcourir tous les objets enfants du dmyNuages
  taille : integer;
begin
  if dmyNuages.ChildrenCount-1 < tbNuages.Value then // Création des TPlane pour les nuages
  begin
    s:=TPlane.Create(nil);
    s.parent := dmyNuages; // La parent du TPlane sera dmyNuages
    taille := random(500); // Taille aléatoire de chaque nuage
    case random(3) mod 3 of    // Affectation alétoirement d'une des 3 textures de nuage disponibles
      0 : begin
            s.MaterialSource:=textureNuage2;
            s.SetSize(taille,taille/2,0.001);
          end;
      1 : begin
            s.MaterialSource:=textureNuage;       // On lui affecte la texture
            s.SetSize(taille,taille/3,0.001);
          end;
      2 : begin
            s.MaterialSource:=textureNuage3;       // On lui affecte la texture
            s.SetSize(taille,taille/1.5,0.001);
          end;
    end;

    s.TwoSide := true;   // Pour que la texture s'applique des deux côtés du TPlane
    s.RotationAngle.X := 90;  // Pour orienter les TPlanes parallèlement au sol
    s.Opacity := random;   // Opacité aléatoire pour améliorer le rendu
    s.Opaque := false;
    s.ZWrite := false;     // pour éviter que le rectangle "cadre" du TPlane soit visible => mais du coup la profondeur n'est plus gérée : le Soleil passe devant les nuages...
    s.HitTest := false;    // pour ne pas pouvoir cliquer dessus
    s.Position.Point:=Point3D(random*2000-1000,-100*random-50,random*1000-500);  // On positionne le nuage arbitrairement et aléatoirement partout au dessus de notre monde
    s.RotationAngle.Z := random * 360; // Orientation aléatoire du nuage
  end;

  for P in dmyNuages.Children do // Parcours des objets enfants du dmyNuages
  begin
    if P is TPlane then // Si l'objet est un TPlane
    begin
      s := TPlane(P);   // On va travailler sur ce TPlane
      s.position.x := s.position.x + 50 / ( -s.Position.Y); // On le décalle sur l'axe X (d'ouest en est) en fonction de son altitude (les nuages les plus bas se déplaceront plus rapidement que ceux d'altitute)
      if s.position.x > 1000  then      // Si la position en X du nuage > 1000, alors on repositionne le nuage à la position x = -1000 et Y et Z valeurs aléatoires
        s.Position.point := Point3D(-1000,-100*random-50,random*1000-500);
    end;
  end;
end;

// Renvoi les dimensions de l'objet 3D
function TfPrincipale.SizeOf3D(const unObjet3D: TControl3D): TPoint3D;
begin
  Result :=NullPoint3D;
  if unObjet3D <> nil then
    result := Point3D(unObjet3D.Width, unObjet3D.Height, unObjet3D.Depth);
end;

function TfPrincipale.DetectionCollisionObstacle:boolean;
var
  unObjet3D:TControl3D; // l'objet en cours de rendu
  DistanceEntreObjets, distanceMinimum: TPoint3D;
  i : integer;
begin
  result := false;
  lblCollision.Text := '';
  for I := 0 to mSol.ChildrenCount-1 do
  begin
    if (mSol.Children[i] is TRectangle3D) or ((mSol.Children[i] is TModel3D) or
        (mSol.Children[i] is TCylinder) or (mSol.Children[i] is TProxyObject)) then
    begin
      // On travail sur l'objet qui est en train d'être calculé
      unObjet3D := TControl3D(mSol.Children[i]);
      DistanceEntreObjets := unObjet3D.AbsoluteToLocal3D(TPoint3D(dmyProchainePosition.AbsolutePosition)); // Distance entre l'objet 3d et la balle
      distanceMinimum := (SizeOf3D(unObjet3D) + SizeOf3D(dmyProchainePosition)) / 2; // distanceMinimum : on divise par 2 car le centre de l'objet est la moitié de la taille de l'élément sur les 3 composantes X, Y, Z

      // Test si la valeur absolue de position est inférieure à la distanceMinimum calculée sur chacune des composantes
      if ((Abs(DistanceEntreObjets.X) < distanceMinimum.X) and (Abs(DistanceEntreObjets.Y) < distanceMinimum.Y) and
          (Abs(DistanceEntreObjets.Z) < distanceMinimum.Z)) then
      begin
        result := true;
        lblCollision.Text := 'Collision avec '+unObjet3D.Name;
        break;
      end;
    end;
  end;
end;

// Exemple trouvé : http://edn.embarcadero.com/article/42012
procedure TfPrincipale.CalcMesh;
var
  M:TMeshData;
  a,x,y : integer;
  sum: single;
  front, back : PPoint3D;
  F : array of TWaveRec;
begin
  M:=TMeshHelper(pMer).Data;
  System.setLength(F,0);

  for a := 0 to pMer.ChildrenCount-1 do
    if pMer.Children[A] is TSphere then
    begin
      system.SetLength(f, system.Length(F)+1);
      with F[System.Length(F)-1] do
      begin
        s:=TSphere(pMer.children[a]);
        s.Position.DefaultValue:=Point3D(0.007, 0.1, 5);  // Amplitude, longueur, vitesse
        p:=Point3d(MaxMerMesh, MaxMerMesh, 0) * 0.5 +s.Position.point * center;
        w:=s.Position.DefaultValue;
      end;
    end;


  for y := 0 to MaxMerMesh do
     for x := 0 to MaxMerMesh do
       begin
         front:=M.VertexBuffer.VerticesPtr[X + (Y * (MaxMerMesh + 1))];
         back:=M.VertexBuffer.VerticesPtr[(MaxMerMesh + 1) * (MaxMerMesh + 1) + X + (Y * (MaxMerMesh + 1))];
         sum:=0;
         for a := 0 to system.Length(F)-1 do sum:=F[a].Wave(sum, x, y,temps);

         sum:=sum*100;
         Front^.Z:=Sum;
         Back^.z:=sum;
       end;

  temps := temps + 0.01;
end;

function TWaveRec.Wave(aSum, aX, aY, aT: single): Single;
var l : single;
begin
  l := P.Distance(Point3d(aX,aY,0));
  Result:=aSum;
  if w.Y > 0  then Result:=Result +w.x * sin (1/w.y*l-w.z*at);
end;

end.
